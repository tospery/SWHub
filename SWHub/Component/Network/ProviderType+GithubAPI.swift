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
    
}
