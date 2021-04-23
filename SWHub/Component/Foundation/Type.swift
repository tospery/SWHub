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
