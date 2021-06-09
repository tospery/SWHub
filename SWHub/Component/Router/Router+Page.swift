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
        navigator.register(self.urlPattern(host: .login)) { url, values, context in
            LoginViewController(navigator, LoginViewReactor.init(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .theme)) { url, values, context in
            ThemeViewController(navigator, ThemeViewReactor.init(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .acknowList)) { _, _, _ in
            AcknowListViewController.init()
        }
        navigator.register(self.urlPattern(host: .search)) { url, values, context in
            guard let parameters = self.parameters(url, values, context) else { return nil }
            guard let path = Path.init(rawValue: parameters[Parameter.path] as? String ?? "")
            else { return nil }
            switch path {
            case .result:
                return SearchResultViewController(navigator, SearchResultViewReactor.init(provider, parameters))
            default:
                return ListViewController(navigator, ListViewReactor.init(provider, parameters))
            }
        }
        let listFactory: ViewControllerFactory = { url, values, context in
            guard let parameters = self.parameters(url, values, context) else { return nil }
            return ListViewController(navigator, ListViewReactor.init(provider, parameters))
        }
        navigator.register(self.urlPattern(host: .repo), listFactory)
        navigator.register(self.urlPattern(host: .repos), listFactory)
        navigator.register(self.urlPattern(host: .user), listFactory)
        navigator.register(self.urlPattern(host: .users), listFactory)
        navigator.register(self.urlPattern(host: .issues), listFactory)
        navigator.register(self.urlPattern(host: .center), listFactory)
        navigator.register(self.urlPattern(host: .profile), listFactory)
        navigator.register(self.urlPattern(host: .about), listFactory)
        navigator.register(self.urlPattern(host: .scheme), listFactory)
        navigator.register(self.urlPattern(host: .feedback), listFactory)
        navigator.register(self.urlPattern(host: .modify), listFactory)
        navigator.register(self.urlPattern(host: .settings), listFactory)
    }

}
