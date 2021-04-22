//
//  ProviderType+Networking.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

let networking = Networking(
    provider: MoyaProvider<MultiTarget>(
        endpointClosure: Networking.endpointClosure,
        requestClosure: Networking.requestClosure,
        stubClosure: Networking.stubClosure,
        callbackQueue: Networking.callbackQueue,
        session: Networking.session,
        plugins: Networking.plugins,
        trackInflights: Networking.trackInflights
    )
)

extension SWFrame.ProviderType {
    
    // MARK: - SWHubAPI
    /// SWHub网站信息：https://api.swhub.com/api/site/info.json
    func siteInfo() -> Single<SiteInfo> {
        networking.requestObject(
            MultiTarget.init(SWHubAPI.siteInfo),
            type: SiteInfo.self
        )
    }
    
}
