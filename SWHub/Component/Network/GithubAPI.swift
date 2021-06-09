//
//  GithubAPI.swift
//  SWHub
//
//  Created by liaoya on 2021/5/10.
//

import Foundation
import Moya

enum GithubAPI {
    case token(code: String)
}

extension GithubAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseGithubUrl.url!
    }

    var path: String {
        switch self {
        case .token: return "/login/oauth/access_token"
        }
    }

    var method: Moya.Method {
        .post
    }

    var headers: [String: String]? {
        [
            "Accept": "application/json"
        ]
    }

    var task: Task {
        switch self {
        case let .token(code):
            let parameters = [
                "client_id": Platform.github.appId,
                "client_secret": Platform.github.appKey,
                "code": code
            ]
//            return .requestCompositeParameters(
//                bodyParameters: parameters,
//                bodyEncoding: URLEncoding.httpBody,
//                urlParameters: basicParameters
//            )
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        }
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
