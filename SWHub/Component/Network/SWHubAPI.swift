//
//  SWHubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import Moya

enum SWHubAPI {
    case login(token: String)
    case user(username: String)
    case modify(key: String, value: String)
    case feedback(title: String, body: String)
    case repo(username: String, reponame: String)
    case readme(username: String, reponame: String, ref: String?)
    case checkStarring(username: String, reponame: String)
    case starRepo(username: String, reponame: String)
    case unstarRepo(username: String, reponame: String)
    case branches(username: String, reponame: String, page: Int)
    case watchers(username: String, reponame: String, page: Int)
    case stargazers(username: String, reponame: String, page: Int)
    case forks(username: String, reponame: String, page: Int)
    case userRepos(username: String, page: Int)
    case userFollowers(username: String, page: Int)
    case pulls(username: String, reponame: String, state: State, page: Int)
    case issues(username: String, reponame: String, state: State, page: Int)
    case starredRepos(username: String, page: Int)
    case searchRepos(keyword: String, sort: Sort, order: Order, page: Int)
    case searchUsers(keyword: String, sort: Sort, order: Order, page: Int)
}

extension SWHubAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .login, .modify: return "/user"
        case .feedback: return "/repos/\(Author.username)/\(Author.reponame)/issues"
        case let .user(username): return "/users/\(username)"
        case let .repo(username, reponame): return "/repos/\(username)/\(reponame)"
        case let .readme(username, reponame, _): return "/repos/\(username)/\(reponame)/readme"
        case .checkStarring(let username, let reponame),
             .starRepo(let username, let reponame),
             .unstarRepo(let username, let reponame):
            return "/user/starred/\(username)/\(reponame)"
        case let .issues(username, reponame, _, _): return "/repos/\(username)/\(reponame)/issues"
        case let .branches(username, reponame, _): return "/repos/\(username)/\(reponame)/branches"
        case let .watchers(username, reponame, _): return "/repos/\(username)/\(reponame)/subscribers"
        case let .stargazers(username, reponame, _): return "/repos/\(username)/\(reponame)/stargazers"
        case let .forks(username, reponame, _): return "/repos/\(username)/\(reponame)/forks"
        case let .userRepos(username, _): return "/users/\(username)/repos"
        case let .userFollowers(username, _): return "/users/\(username)/followers"
        case let .pulls(username, reponame, _, _): return "/repos/\(username)/\(reponame)/pulls"
        case let .starredRepos(username, _): return "/users/\(username)/starred"
        case .searchRepos: return "/search/repositories"
        case .searchUsers: return "/search/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .feedback: return .post
        case .starRepo: return .put
        case .unstarRepo: return .delete
        case .modify: return .patch
        default: return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case let .login(token):
            return ["Authorization": "token \(token)"]
        default:
            if let token = User.current?.token {
                return ["Authorization": "token \(token)"]
            }
            return nil
        }
    }

    var task: Task {
        var encoding: ParameterEncoding = URLEncoding.default
        var parameters = [String: Any].init()
        switch self {
        case let .feedback(title, body):
            parameters["title"] = title
            parameters["body"] = body
            encoding = JSONEncoding.default
        case let .modify(key, value):
            parameters[key] = value
            encoding = JSONEncoding.default
        case .issues(_, _, let state, let page),
             .pulls(_, _, let state, let page):
            parameters["state"] = state.rawValue
            parameters["page"] = page
            parameters["per_page"] = UIApplication.shared.pageSize
        case let .readme(_, _, ref):
            parameters["ref"] = ref
        case .searchRepos(let keyword, let sort, let order, let page),
             .searchUsers(let keyword, let sort, let order, let page):
            parameters["q"] = keyword
            parameters["sort"] = sort.rawValue
            parameters["order"] = order.rawValue
            parameters["page"] = page
            parameters["per_page"] = UIApplication.shared.pageSize
        case .branches(_, _, let page),
             .watchers(_, _, let page),
             .stargazers(_, _, let page),
             .forks(_, _, let page),
             .userRepos(_, let page),
             .starredRepos(_, let page),
             .userFollowers(_, let page):
            parameters["page"] = page
            parameters["per_page"] = UIApplication.shared.pageSize
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data {
//        var path = self.path.replacingOccurrences(of: "/", with: "-")
//        let index = path.index(after: path.startIndex)
//        path = String(path[index...])
//        if let url = Bundle.main.url(forResource: path, withExtension: "json"),
//            let data = try? Data(contentsOf: url) {
//            return data
//        }
//        return Data()
        Data.init()
    }

}
