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
    case test
    
    enum Web: String {
        case agreement      = "about"
        case privacy        = "mission"
        
        var urlString: String {
            "\(UIApplication.shared.baseWebUrl)/\(self.rawValue)"
        }
    }
    
    enum Topic: String {
        case list
        case detail

        var urlString: String {
            "\(UIApplication.shared.scheme)://topic/\(self.rawValue)"
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
