//
//  TrendingAPI.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

enum TrendingAPI {
    case languages
    case developers(language: Language?, since: Since?)
    case repositories(language: Language?, since: Since?)
}

extension TrendingAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseTrendingUrl.url!
    }

    var path: String {
        switch self {
        case .languages: return "/languages"
        case .developers: return "/developers"
        case .repositories: return "/repositories"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        var parameters = basicParameters
        switch self {
        case .developers(let language, let since),
             .repositories(let language, let since):
            parameters["language"] = language?.urlParam
            parameters["since"] = since?.paramValue
        default:
            break
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
