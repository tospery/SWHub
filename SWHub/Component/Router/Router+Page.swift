//
//  Router+Page.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension Router {
    
    static func page(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        let parameters = { (url: URLNavigator.URLConvertible, values: [String: Any], context: Any?) -> [String: Any]? in
            var parameters: [String: Any] = url.queryParameters
            for (key, value) in values {
                parameters[key] = value
            }
            if let context = context {
                parameters[Parameter.routeContext] = context
            }
            return parameters
        }
        navigator.register(self.login.urlString) { url, values, context in
            LoginViewController(navigator, LoginViewReactor(provider, parameters(url, values, context)))
        }
    }
    
}
