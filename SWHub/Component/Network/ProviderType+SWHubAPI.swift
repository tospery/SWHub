//
//  ProviderType+SWHubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

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
    
}
