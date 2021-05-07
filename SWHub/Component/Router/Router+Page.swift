//
//  Router+Page.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import AcknowList

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
        navigator.register(self.feedback.urlString) { url, values, context in
            FeedbackViewController(navigator, FeedbackViewReactor(provider, parameters(url, values, context)))
        }
        navigator.register(self.about.urlString) { url, values, context in
            AboutViewController(navigator, AboutViewReactor(provider, parameters(url, values, context)))
        }
        navigator.register(self.acknowList.urlString) { _, _, _ in
            let vc = AcknowListViewController.init()
            vc.hidesBottomBarWhenPushed = true
            return vc
        }
        navigator.register(Issue.list.urlString) { url, values, context in
            IssueListViewController(navigator, IssueListViewReactor(provider, parameters(url, values, context)))
        }
    }
    
}
