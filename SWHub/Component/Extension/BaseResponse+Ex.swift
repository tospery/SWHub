//
//  BaseResponse+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import Moya

extension BaseResponse: ResponseCompatible {
    
    public func code(map: Map) -> Int {
        var code: Int!
        code        <- map["code"]
        code = code == nil ? -1 : code
        return code == 0 ? HTTPStatusCode.Success.ok.rawValue : code
    }
    
    public func message(map: Map) -> String {
        var message: String?
        message         <- map["msg"]
        return message ?? ""
    }
    
    public func data(map: Map) -> Any? {
        var data: Any?
        data        <- map["data"]
        return data
    }
    
    public func code(_ target: TargetType) -> Int {
        return self.code
    }
    
    public func message(_ target: TargetType) -> String {
        return self.message
    }
    
    public func data(_ target: TargetType) -> Any? {
        return self.data
    }

}
