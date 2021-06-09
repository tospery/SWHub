//
//  ProviderType+TrendingAPI.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation
import Moya

extension SWFrame.ProviderType {
    
    // MARK: - TrendingAPI
    /// 仓库推荐: https://gtrend.yapie.me/repositories
    func repositories(language: Language?, since: Since?) -> Single<[Repo]> {
        return networking.requestArray(
            MultiTarget.init(
                TrendingAPI.repositories(language: language, since: since)
            ),
            type: Repo.self
        )
    }
    
    /// 开发者推荐: https://gtrend.yapie.me/developers
    func developers(language: Language?, since: Since?) -> Single<[User]> {
        networking.requestArray(
            MultiTarget.init(
                TrendingAPI.developers(language: language, since: since)
            ),
            type: User.self
        )
    }
    
    /// 编程语言
    func languages() -> Single<[Language]> {
        networking.requestArray(
            MultiTarget.init(
                TrendingAPI.languages
            ),
            type: Language.self
        )
    }
    
}
