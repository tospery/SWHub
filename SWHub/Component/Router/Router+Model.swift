//
//  Router+Model.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension Router {
    
    static func model(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.handle(self.toast.urlString) { url, _, _ -> Bool in
            guard let window = AppDependency.shared.window else { return false }
            if let message = url.queryParameters[Parameter.message] {
                window.makeToast(message)
            } else if let active = url.queryParameters[Parameter.active] {
                (active.bool ?? false) ? window.makeToastActivity(.center) : window.hideToastActivity()
            } else {
                return false
            }
            return true
        }
        navigator.handle(self.alert.urlString) { _, _, _ -> Bool in
//            let title = url.queryParameters[Parameter.title]
//            let message = url.queryParameters[Parameter.message]
//            if title?.isEmpty ?? true && message?.isEmpty ?? true {
//                return false
//            }
//            let attributes = self.attributes(url.queryParameters[Parameter.name])
//            let alertMessageView = self.alertMessageView(title, message, context)
//            SwiftEntryKit.display(entry: alertMessageView, using: attributes)
            return true
        }
    }
    
}
