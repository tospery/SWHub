//
//  SWHubAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum SWHubAPI {
    case login(token: String)
}

extension SWHubAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .login: return "/user"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        switch self {
        case let .login(token):
            return ["Authorization": "token \(token)"]
        }
    }

    var task: Task { .requestPlain }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() } // YJX_TODO 示例

}
