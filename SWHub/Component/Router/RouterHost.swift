//
//  RouterHost.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/22.
//

import Foundation

extension Router {
    
    /// scheme分类
    /// - 需要用户登录
    /// 将必要的参数作为path
    enum Host: String {
        case toast, alert, sheet, popup
        case center, profile, feedback      // 不暴露的与登录用户关联的host
        case user, users
        case repo, repos
        case issue, issues
        case search
        case login, about, acknowList, theme, scheme, modify, settings
        
        var isList: Bool {
            self == .users || self == .repos || self == .issues
        }
        
        var title: String? {
            switch self {
            case .user: return R.string.localizable.user()
            case .users: return R.string.localizable.developers()
            case .repo: return R.string.localizable.repository()
            case .repos: return R.string.localizable.repositories()
            case .issue: return R.string.localizable.issues()
            case .issues: return R.string.localizable.issues()
            case .center: return R.string.localizable.me()
            case .profile: return R.string.localizable.profile()
            case .about: return R.string.localizable.about()
            case .scheme: return R.string.localizable.aboutPortalSchemes()
            case .feedback: return R.string.localizable.feedback()
            case .settings: return R.string.localizable.settings()
            default: return nil
            }
        }
        
        var allowedPaths: [Path] {
            switch self {
            case .repos, .users:
                return [.trending, .stars, .search]
            case .search:
                return [.history, .result]
            default:
                return []
            }
        }
        
    }
    
}
