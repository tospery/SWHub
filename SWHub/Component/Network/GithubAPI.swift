//
//  GithubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum GithubAPI {
    case login(token: String)
    case feedback(title: String, body: String)
}

extension GithubAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .login: return "/user"
        case .feedback: return "/repos/\(User.current?.login ?? "")/SWHub/issues"
        }
    }

    var method: Moya.Method {
        switch self {
        case .feedback: return .post
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
        switch self {
        case let .feedback(title, body):
            let parameters = [
                "title": title,
                "body": body
            ]
            return .requestCompositeParameters(
                bodyParameters: parameters,
                bodyEncoding: JSONEncoding.default,
                urlParameters: basicParameters
            )
        default:
            return .requestPlain
        }
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() } // YJX_TODO 示例

}
