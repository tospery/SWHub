//
//  Networking.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import Moya

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

struct Networking: NetworkingType {

    typealias Target = MultiTarget
    let provider: MoyaProvider<MultiTarget>
    
    func request<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<Model> {
        self.requestJSON(target).flatMap { json -> Single<Model> in
            guard let json = json as? [String: Any] else {
                return .error(SWFError.dataFormat)
            }
            guard let model = Model.init(JSON: json), model.isValid else {
                return .error(SWFError.server(0, json["message"] as? String))
            }
            return .just(model)
        }
    }
    
    func requestArray<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<[Model]> {
        self.requestJSON(target).flatMap { json -> Single<[Model]> in
            if let info = json as? [String: Any],
               let message = info["message"] as? String {
                return .error(SWFError.server(0, message))
            }
            guard let json = json as? [[String: Any]] else {
                return .error(SWFError.dataFormat)
            }
            let models = [Model].init(JSONArray: json)
            return .just(models)
        }
    }
    
    func requestList<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<List<Model>> {
        self.requestJSON(target).flatMap { json -> Single<List<Model>> in
            guard let json = json as? [String: Any] else {
                return .error(SWFError.dataFormat)
            }
            guard let list = List<Model>.init(JSON: json) else {
                return .error(SWFError.server(0, json["message"] as? String))
            }
            return .just(list)
        }
    }
    
//    static var endpointClosure: MoyaProvider<Target>.EndpointClosure {
//        return { target in
//            return Endpoint(
//                url: URL(target: target).absoluteString,
//                sampleResponseClosure: { .networkError(
//    NSError(domain: NSURLErrorDomain, code: -1234, userInfo: nil)) },
//                method: target.method,
//                task: target.task,
//                httpHeaderFields: target.headers
//            )
//        }
//    }
//
//    static var stubClosure: MoyaProvider<Target>.StubClosure {
//        return { target in
//            return .delayed(seconds: 5)
//        }
//    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        let logger = NetworkLoggerPlugin.init()
        logger.configuration.logOptions = [.requestBody, .successResponseBody, .errorResponseBody]
        logger.configuration.output = output
        plugins.append(logger)
        return plugins
    }
    
    static func output(target: TargetType, items: [String]) {
        for item in items {
            log(item, module: .restful)
        }
    }
    
}
