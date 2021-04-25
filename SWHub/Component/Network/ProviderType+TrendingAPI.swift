//
//  ProviderType+TrendingAPI.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

extension SWFrame.ProviderType {
    
    // MARK: - TrendingAPI
    /// 仓库推荐
    func repositories(language: Language?, since: Since?) -> Single<[Repo]> {
        networking.requestArray(
            MultiTarget.init(
                TrendingAPI.repositories(language: language, since: since)
            ),
            type: Repo.self
        )
    }
    
}
