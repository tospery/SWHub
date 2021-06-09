//
//  ProviderType+GithubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/10.
//

import Foundation
import Moya

extension SWFrame.ProviderType {
    
    // MARK: - GithubAPI
    /// 用户登录
    func token(code: String) -> Single<Token> {
        networking.request(
            MultiTarget.init(
                GithubAPI.token(code: code)
            ),
            type: Token.self
        )
    }
    
}
