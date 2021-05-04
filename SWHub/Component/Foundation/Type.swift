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
    case restful    = "RESTful"
}

enum Platform {
    case github
    
    var appId: String {
        switch self {
        case .github: return "826519ff4600bcfd06fe"
        }
    }
    
    var appKey: String {
        switch self {
        case .github: return "c071b276632d4d2c219d3db8d3dee516e01b1c74"
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

enum Portal: Int {
    case feedback
    case about
    
    static let allValues = [feedback, about]
    
    var title: String {
        switch self {
        case .feedback: return R.string.localizable.feedback()
        case .about: return R.string.localizable.about()
        }
    }
    
    var image: UIImage {
        switch self {
        case .feedback: return R.image.feedback()!
        case .about: return R.image.about()!
        }
    }
    
}
