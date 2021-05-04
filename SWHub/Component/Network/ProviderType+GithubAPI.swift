//
//  ProviderType+GithubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension SWFrame.ProviderType {
    
    // MARK: - GithubAPI
    /// 用户登录
    func login(token: String) -> Single<User> {
        networking.request(
            MultiTarget.init(
                GithubAPI.login(token: token)
            ),
            type: User.self
        )
    }
    
    /// 反馈
    func feedback(title: String, body: String) -> Single<Void> {
        networking.request(
            MultiTarget.init(
                GithubAPI.feedback(title: title, body: body)
            ),
            type: FeedbackResponse.self
        ).flatMap { _ -> Single<Void> in
            .just(())
        }
    }
    
    /// Issues
    func issues(state: State, page: Int) -> Single<[Issue]> {
        networking.requestArray(
            MultiTarget.init(
                GithubAPI.issues(state: state, page: page)
            ),
            type: Issue.self
        )
    }
    
}
