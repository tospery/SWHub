//
//  SWFError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

public enum SWFError: Error {
    case unknown
    case network
    case navigation
    case dataFormat
    case listIsEmpty
    case notLoginedIn
    case server(Int, String?)
    case app(Int, String?)
}

extension SWFError: CustomNSError {
    public static let domain = "com.swframe.error"
    public var errorCode: Int {
        switch self {
        case .unknown: return 1
        case .network: return 2
        case .navigation: return 3
        case .dataFormat: return 4
        case .listIsEmpty: return 5
        case .notLoginedIn: return 6
        case let .server(code, _): return code
        case let .app(code, _): return code
        }
    }
}

extension SWFError: LocalizedError {
    /// 概述
    public var failureReason: String? {
        switch self {
        case .unknown: return NSLocalizedString("Error.Unknown.Title", value: "未知错误", comment: "")
        case .network: return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .navigation: return NSLocalizedString("Error.Navigation.Title", value: "导航错误", comment: "")
        case .dataFormat: return NSLocalizedString("Error.DataFormat.Title", value: "数据格式异常", comment: "")
        case .listIsEmpty: return NSLocalizedString("Error.ListIsEmpty.Title", value: "列表为空", comment: "")
        case .notLoginedIn: return NSLocalizedString("Error.NotLoginedIn.Title", value: "用户未登录", comment: "")
        case .server: return NSLocalizedString("Error.Server.Title", value: "服务异常", comment: "")
        case .app: return NSLocalizedString("Error.App.Title", value: "操作错误", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("Error.Unknown.Message", value: "未知错误", comment: "")
        case .network: return NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case .navigation: return NSLocalizedString("Error.Navigation.Message", value: "导航错误", comment: "")
        case .dataFormat: return NSLocalizedString("Error.DataFormat.Message", value: "数据格式异常", comment: "")
        case .listIsEmpty: return NSLocalizedString("Error.ListIsEmpty.Message", value: "列表为空", comment: "")
        case .notLoginedIn: return NSLocalizedString("Error.NotLoginedIn.Message", value: "用户未登录", comment: "")
        case let .server(_, message): return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .app(_, message): return message ?? NSLocalizedString("Error.App.Message", value: "操作错误", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }

}

extension SWFError: Equatable {
    public static func == (lhs: SWFError, rhs: SWFError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
             (.network, .network),
             (.navigation, .navigation),
             (.dataFormat, .dataFormat),
             (.listIsEmpty, .listIsEmpty),
             (.notLoginedIn, .notLoginedIn):
            return true
        case (.server(let left, _), .server(let right, _)),
             (.app(let left, _), .app(let right, _)):
            return left == right
        default: return false
        }
    }
}

extension SWFError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: return "SWFError.unknown"
        case .network: return "SWFError.network"
        case .navigation: return "SWFError.navigation"
        case .dataFormat: return "SWFError.dataFormat"
        case .listIsEmpty: return "SWFError.listIsEmpty"
        case .notLoginedIn: return "SWFError.notLoginedIn"
        case let .server(code, message): return "SWFError.server(\(code), \(message))"
        case let .app(code, message): return "SWFError.app(\(code), \(message))"
        }
    }
}

extension SWFError {
    public var isNetwork: Bool {
        self == .network
    }
    public var isServer: Bool {
        if case .server = self {
            return true
        }
        return false
    }
    public var isListIsEmpty: Bool {
        self == .listIsEmpty
    }
    public var isNotLoginedIn: Bool {
        self == .notLoginedIn
    }
    public var displayImage: UIImage? {
        if self.isNetwork {
            return UIImage.networkError
        } else if self.isServer {
            return UIImage.serverError
        } else if self.isListIsEmpty {
            return UIImage.emptyError
        } else if self.isNotLoginedIn {
            return UIImage.expireError
        }
        return nil
    }
    
    public func isServerError(withCode errorCode: Int) -> Bool {
        if case let .server(code, _) = self {
            return errorCode == code
        }
        return false
    }
    
    public func isAppError(withCode errorCode: Int) -> Bool {
        if case let .app(code, _) = self {
            return errorCode == code
        }
        return false
    }
    
}
