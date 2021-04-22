//
//  Error.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum APPError: Error {
    case loginFailure(String?)
}

extension APPError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .loginFailure: return 1
        }
    }
}

extension APPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .loginFailure(message): return message ?? R.string.localizable.errorLogin()
        }
    }
}

extension APPError: SWCompatibleError {
    public var swError: SWError {
        .app(self.errorCode, self.errorDescription)
    }
}
