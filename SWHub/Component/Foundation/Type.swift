//
//  Type.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum TabBarKey {
    case home
    case mine
}

enum LogModule: String {
    case common     = "Common"
    case library    = "Library"
    case restful    = "RESTful"
}

enum Platform {
    case github
    case umeng
    case weixin
    
    var appId: String {
        switch self {
        case .github: return "826519ff4600bcfd06fe"
        case .umeng: return "6093ae3653b6726499ec3983"
        case .weixin: return "wx3eaaadb0d5693f94"
        }
    }
    
    var appKey: String {
        switch self {
        case .github: return "c071b276632d4d2c219d3db8d3dee516e01b1c74"
        case .umeng: return "6093ae3653b6726499ec3983"
        case .weixin: return "f7f6a7c1cbe503c497151e076c0a4b4d"
        }
    }

    var appLink: String {
        switch self {
        case .weixin: return "https://tospery.com/swhub/"
        default: return ""
        }
    }

}

enum State: String {
    case open
    case closed
    case all
}

enum Since {
    case daily
    case weekly
    case montly
    
    var paramValue: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .montly: return "montly"
        }
    }
}
