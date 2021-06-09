//
//  UIApplication+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension UIApplication {
    
    var baseTrendingUrl: String {
        "https://gtrend.yapie.me"
    }
    
    var baseGithubUrl: String {
        "https://github.com"
    }

    @objc var myBaseApiUrl: String {
        "https://api.github.com"
    }

    @objc var myBaseWebUrl: String {
        "https://m.github.com"
    }

}

extension UIApplication.Environment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .debug: return "Debug"
        case .testFlight: return "TestFlight"
        case .appStore: return "AppStore"
        }
    }
}
