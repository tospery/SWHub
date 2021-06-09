//
//  Error.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import SafariServices

enum APPError: Error {
    case oauthFailure
    case oauthCancle
    case loginFailure(String?)
}

extension APPError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .oauthFailure: return 1
        case .oauthCancle: return 2
        case .loginFailure: return 3
        }
    }
}

extension APPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .oauthFailure: return R.string.localizable.errorOauthFailure()
        case .oauthCancle: return R.string.localizable.errorOauthCancel()
        case let .loginFailure(message): return message ?? R.string.localizable.errorLogin()
        }
    }
}

extension APPError: SWFErrorCompatible {
    public var swfError: SWFError {
        .app(self.errorCode, self.errorDescription)
    }
}

extension SFAuthenticationError: SWFErrorCompatible {
    public var swfError: SWFError {
        switch self.code {
        case .canceledLogin:
            return APPError.oauthCancle.asSWFError
        @unknown default:
            return APPError.oauthFailure.asSWFError
        }
    }
}

extension RxOptionalError: SWFErrorCompatible {
    public var swfError: SWFError {
        switch self {
        case .emptyOccupiable: return .listIsEmpty
        case .foundNilWhileUnwrappingOptional: return .dataFormat
        }
    }
}
