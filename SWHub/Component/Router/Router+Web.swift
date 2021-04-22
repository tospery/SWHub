//
//  Router+Web.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension Router {
    
    static func web(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        let webFactory: ViewControllerFactory = { (url: URLNavigator.URLConvertible, _, context: Any?) in
            guard let url = url.urlValue else { return nil }
            // (1) 原生支持
            let string = url.absoluteString
            let base = UIApplication.shared.baseWebUrl + "/"
            if string.hasPrefix(base) {
                let url = string.replacingOccurrences(of: base, with: UIApplication.shared.scheme + "://")
                if navigator.push(url, context: context) != nil {
                    return nil
                }
                if navigator.open(url, context: context) {
                    return nil
                }
            }
            // (2) 网页跳转
            var paramters = [Parameter.url: url.absoluteString]
            if let title = url.queryValue(for: Parameter.title) {
                paramters[Parameter.title] = title
            }

            return WebViewController(navigator, WebViewReactor(provider, paramters))
        }
        navigator.register("http://<path:_>", webFactory)
        navigator.register("https://<path:_>", webFactory)
    }
    
}
