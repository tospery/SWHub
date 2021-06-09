//
//  ProviderType+SWHubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import Moya

extension SWFrame.ProviderType {
    
    // MARK: - SWHubAPI
    /// 用户登录
    func login(token: String) -> Single<User> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.login(token: token)
            ),
            type: User.self
        )
    }
    
    /// 用户信息
    /// - API: https://docs.github.com/en/rest/reference/users#get-a-user
    /// - Demo: https://api.github.com/users/ReactiveX
    func user(username: String) -> Single<User> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.user(username: username)
            ),
            type: User.self
        )
    }
    
    /// 修改用户信息
    /// - API: https://docs.github.com/en/rest/reference/users#update-the-authenticated-user
    /// - Demo: https://api.github.com/user
    func modify(key: String, value: String) -> Single<User> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.modify(key: key, value: value)
            ),
            type: User.self
        )
    }
    
    /// 提交问题
    /// - API: https://docs.github.com/en/rest/reference/issues#create-an-issue
    /// - Demo: https://api.github.com/repos/tospery/SWHub/issues
    func feedback(title: String, body: String) -> Single<Issue> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.feedback(title: title, body: body)
            ),
            type: Issue.self
        )
    }
    
    /// 问题列表
    /// - API: https://docs.github.com/en/rest/reference/issues#list-repository-issues
    /// - Demo: https://api.github.com/repos/ReactiveX/RxSwift/issues?state=open&page=1
    func issues(username: String, reponame: String, state: State, page: Int) -> Single<[Issue]> {
        networking.requestArray(
            MultiTarget.init(
                SWHubAPI.issues(username: username, reponame: reponame, state: state, page: page)
            ),
            type: Issue.self
        )
    }
    
    /// 仓库详情
    /// - API: https://docs.github.com/rest/reference/repos#get-a-repository
    /// - Demo: https://api.github.com/repos/ReactiveX/RxSwift
    func repo(username: String, reponame: String) -> Single<Repo> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.repo(username: username, reponame: reponame)
            ),
            type: Repo.self
        )
    }
    
    /// README
    /// - API: https://docs.github.com/en/rest/reference/repos#get-a-repository-readme
    /// - Demo: https://api.github.com/repos/ReactiveX/RxSwift/readme
    func readme(username: String, reponame: String, ref: String?) -> Single<Readme> {
        networking.request(
            MultiTarget.init(
                SWHubAPI.readme(username: username, reponame: reponame, ref: ref)
            ),
            type: Readme.self
        )
    }
    
    /// 分支列表
    /// - API: https://docs.github.com/en/rest/reference/repos#list-branches
    /// - Demo: https://api.github.com/repos/ReactiveX/RxSwift/branches?page=1
    func branches(username: String, reponame: String, page: Int) -> Single<[Branch]> {
        networking.requestArray(
            MultiTarget.init(
                SWHubAPI.branches(username: username, reponame: reponame, page: page)
            ),
            type: Branch.self
        )
    }

    /// 拉取列表
    /// - API: https://docs.github.com/rest/reference/pulls#list-pull-requests
    /// - Demo: https://api.github.com/repos/reactivex/rxswift/pulls?state=open&page=1
    func pulls(username: String, reponame: String, state: State, page: Int) -> Single<[Pull]> {
        networking.requestArray(
            MultiTarget.init(
                SWHubAPI.pulls(username: username, reponame: reponame, state: state, page: page)
            ),
            type: Pull.self
        )
    }
    
    /// 用户关注的仓库列表
    /// - API: https://docs.github.com/en/rest/reference/activity#list-repositories-starred-by-a-user
    /// - Demo: https://api.github.com/users/tospery/starred?page=1&per_page=20
    func starredRepos(username: String, page: Int) -> Single<[Repo]> {
        networking.requestArray(
            MultiTarget.init(
                SWHubAPI.starredRepos(username: username, page: page)
            ),
            type: Repo.self
        )
    }
    
    /// 搜索仓库
    /// - API: https://docs.github.com/v3/search
    /// - Demo: https://api.github.com/search/repositories?q=rxswift
    func searchRepos(keyword: String, sort: Sort = .stars, order: Order = .desc, page: Int) -> Single<[Repo]> {
        networking.requestList(
            MultiTarget.init(
                SWHubAPI.searchRepos(keyword: keyword, sort: sort, order: order, page: page)
            ),
            type: Repo.self
        ).map { $0.items }
    }
    
    /// 搜索开发者
    /// - API: https://docs.github.com/v3/search
    /// - Demo: https://api.github.com/search/users?q=rxswift
    func searchUsers(keyword: String, sort: Sort = .stars, order: Order = .desc, page: Int) -> Single<[User]> {
        networking.requestList(
            MultiTarget.init(
                SWHubAPI.searchUsers(keyword: keyword, sort: sort, order: order, page: page)
            ),
            type: User.self
        ).map { $0.items }
    }
    
}
