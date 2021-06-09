//
//  Const.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

/// 该项目不需要通用参数
let basicParameters: [String: Any] = [
    "source": 1,
    "channel": (UIApplication.shared.inferredEnvironment == .debug
                    ? 1 : (UIApplication.shared.inferredEnvironment
                            == .testFlight ? 2 : 3)),
    "os_version": UIDevice.current.systemVersion,
    "app_type": 1,
    "app_version": UIApplication.shared.version!,
    "device_id": UIDevice.current.uuid
]

enum TabBarKey {
    case trending
    case events
    case stars
    case me
    
    static let allValues = [trending, stars, me]
    
    var title: String {
        switch self {
        case .trending: return R.string.localizable.trending()
        case .events: return R.string.localizable.events()
        case .stars: return R.string.localizable.stars()
        case .me: return R.string.localizable.me()
        }
    }
    
    var image: UIImage {
        switch self {
        case .trending: return R.image.tabbar_trending()!
        case .events: return R.image.tabbar_message()!
        case .stars: return R.image.tabbar_stars()!
        case .me: return R.image.tabbar_mine()!
        }
    }
}

enum PageKey {
    case repos
    case users

    static let allValues = [repos, users]
    
    var title: String {
        switch self {
        case .repos:
            return R.string.localizable.repositories()
        case .users:
            return R.string.localizable.developers()
        }
    }
}

enum Platform {
    case github
    case umeng
    case weixin
    
    var appId: String {
        switch self {
        case .github: return "826519ff4600bcfd06fe"
        case .umeng: return "6093ae3653b6726499ec3983"
        case .weixin: return UIApplication.shared.urlScheme(name: "weixin") ?? ""
        }
    }
    
    var appKey: String {
        switch self {
        case .github: return "c071b276632d4d2c219d3db8d3dee516e01b1c74"
        case .umeng: return "6093ae3653b6726499ec3983"
        case .weixin: return "f7f6a7c1cbe503c497151e076c0a4b4d"
        }
    }

//    var appSecret: String {
//        ""
//    }
    
    var appLink: String {
        switch self {
        case .weixin: return "https://tospery.com/swhub/"
        default: return ""
        }
    }

}

enum EventType: String, Codable {
    case watchEvent                 = "WatchEvent"
    case createEvent                = "CreateEvent"
    case forkEvent                  = "ForkEvent"
    case deleteEvent                = "DeleteEvent"
    case pushEvent                  = "PushEvent"
    case issueCommentEvent          = "IssueCommentEvent"
    
}

enum Sort: String, Codable {
    case stars
    case forks
    case updated
    case issues  = "help-wanted-issues"
}

enum Order: String, Codable {
    case desc
    case asc
}

enum State: String, Codable {
    case open
    case closed
    case all
    
    var icon: UIImage? {
        switch self {
        case .open: return R.image.issue_open()
        case .closed: return R.image.issue_closed()
        default: return nil
        }
    }
    
}

enum Since: String, Codable {
    case daily
    case weekly
    case montly
    
    static let name = R.string.localizable.since()
    static let allValues = [daily, weekly, montly]
    
//    var paramValue: String {
//        switch self {
//        case .daily: return R.string.localizable.daily()
//        case .weekly: return R.string.localizable.weekly()
//        case .montly: return R.string.localizable.montly()
//        }
//    }
}

//enum ListType: String {
//    case repos
//    
//    var title: String? {
//        switch self {
//        case .repos: return R.string.localizable.repositories()
//        }
//    }
//}

enum Identifier {
    case logout
}

struct Author {
    
    static let username = "tospery"
    static let reponame = "SWHub"
}

struct Metric {
    
    static let padding = 10.f
    static let margin = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    static let trendingMaxLines = 3
    static let summaryMaxLines = 5
    static let repoStatusHeight = 15.f
    static let menuScale = 0.75.f
    
    struct Trending {
        static let starsSize = CGSize.init(width: 60, height: 30)
        static let iconSize = CGSize.init(28)
        static let nameHeight = 40.f
        static let subnameHeight = 25.f
        static let descFont = UIFont.normal(15)
    }
    
}
