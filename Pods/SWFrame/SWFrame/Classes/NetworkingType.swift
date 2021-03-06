//
//  NetworkingType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/8/19.
//

import UIKit
import RxSwift
import Moya
import Alamofire
import ObjectMapper

public protocol NetworkingType {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get }
}

public extension NetworkingType {
    static var endpointClosure: MoyaProvider<Target>.EndpointClosure {
        return { target in
            return MoyaProvider.defaultEndpointMapping(for: target)
        }
    }
    
    static var requestClosure: MoyaProvider<Target>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = true
                request.timeoutInterval = 15
                closure(.success(request))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    static var stubClosure: MoyaProvider<Target>.StubClosure {
        return { _ in
            return .never
        }
    }

    static var callbackQueue: DispatchQueue? {
        return nil
    }
    
    static var session: Session {
        return MoyaProvider<Target>.defaultAlamofireSession()
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        let logger = NetworkLoggerPlugin.init()
        logger.configuration.logOptions = [.requestBody, .successResponseBody, .errorResponseBody]
        // logger.configuration.output = output
        plugins.append(logger)
        return plugins
    }
    
    static var trackInflights: Bool {
        return false
    }

}

public extension NetworkingType {
    func request(_ target: Target) -> Single<Moya.Response> {
        //        NSURLErrorTimedOut(-1001): 请求超时
        //        NSURLErrorCannotConnectToHost(-1004): 找不到服务
        //        NSURLErrorDataNotAllowed(-1020): 网络不可用
        self.provider.rx.request(target)/*.filterSuccessfulStatusCodes()*/.catchError { Single<Moya.Response>.error($0.asSWFError)
        }
    }
    
    func requestRaw(_ target: Target) -> Single<Moya.Response> {
        return self.request(target)
            .observeOn(MainScheduler.instance)
    }
    
    func requestJSON(_ target: Target) -> Single<Any> {
        return self.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
    }
    
    func requestObject<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<Model> {
        return self.request(target)
            .mapObject(Model.self)
            .observeOn(MainScheduler.instance)
    }
    
    func requestArray<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<[Model]> {
        return self.request(target)
            .mapArray(Model.self)
            .observeOn(MainScheduler.instance)
    }
    
    func requestBase(_ target: Target) -> Single<BaseResponse> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<BaseResponse> in
                if let error = self.check(response.code(target), response.message(target)) {
                    return .error(error)
                }
                return .just(response)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestData(_ target: Target) -> Single<Any?> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<Any?> in
                if let error = self.check(response.code(target), response.message(target)) {
                    return .error(error)
                }
                return .just(response.data(target))
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestModel<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<Model> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<Model> in
                if let error = self.check(response.code(target), response.message(target)) {
                    return .error(error)
                }
                let data = response.data(target)
                guard let json = data as? [String: Any],
                      let model = Model.init(JSON: json) else {
                    return .error(SWFError.dataFormat)
                }
                return .just(model)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestModels<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<[Model]> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<[Model]> in
                if let error = self.check(response.code(target), response.message(target)) {
                    return .error(error)
                }
                guard let json = response.data(target) as? [[String: Any]] else {
                    return .error(SWFError.dataFormat)
                }
                let models = [Model].init(JSONArray: json)
//                if models.count == 0 {
//                    return .error(SWFError.listIsEmpty)
//                }
                return .just(models)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestList<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<List<Model>> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<List<Model>> in
                if let error = self.check(response.code(target), response.message(target)) {
                    return .error(error)
                }
                guard let json = response.data(target) as? [String: Any],
                      let list = List<Model>.init(JSON: json) else {
                        return .error(SWFError.dataFormat)
                }
//                if list.items.count == 0 {
//                    return .error(SWFError.listIsEmpty)
//                }
                return .just(list)
        }
        .observeOn(MainScheduler.instance)
    }
    
    private func check(_ code: Int, _ message: String) -> SWFError? {
        guard code == HTTPStatusCode.Success.ok.rawValue else {
            if code == HTTPStatusCode.Client.unauthorized.rawValue {
                return .notLoginedIn
            }
            return SWFError.server(code, message)
        }
        return nil
    }
    
}

