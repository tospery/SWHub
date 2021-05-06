//
//  Router.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Router: String {
    case toast
    case alert
    case sheet
    case popup
    case login
    case feedback
    case about
    case test
    
    enum Web: String {
        case agreement      = "about"
        case privacy        = "mission"
        case oauth
        case homepage
        
        var urlString: String {
            switch self {
            case .oauth:
                return """
                    http://github.com/login/oauth/authorize?\
                    client_id=\(Platform.github.appId)&\
                    scope=user+repo+notifications+read:org
                    """
            case .homepage:
                return "https://github.com/tospery/SWHub"
            default:
                return "\(UIApplication.shared.baseWebUrl)/\(self.rawValue)"
            }
        }
    }
    
    enum Issue: String {
        case list
        case detail

        var urlString: String {
            "\(UIApplication.shared.scheme)://issue/\(self.rawValue)"
        }
    }
    
    var urlString: String {
        "\(UIApplication.shared.scheme)://\(self.rawValue)"
    }

    static func initialize(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        self.web(provider, navigator)
        self.page(provider, navigator)
        self.model(provider, navigator)
    }
    
}
