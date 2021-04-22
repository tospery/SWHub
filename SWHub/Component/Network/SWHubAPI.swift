//
//  SWHubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum SWHubAPI {
    case siteInfo
}

extension SWHubAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .siteInfo: return "/api/site/info.json"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task { .requestPlain }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
