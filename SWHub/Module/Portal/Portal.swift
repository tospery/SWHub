//
//  Portal.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import Foundation

enum Portal: Int {
    case unknown, summaryUser, summaryRepo, app
    case theme, feedback, acknowlist, settings, about
    case name, bio, company, location, email, blog
    case author, scheme, ratings, invite
    case language, issues, pulls, branches, readmeRefresh, readmeContent
    case textField, textView, button, feedbackInput, feedbackNote
    case searchHistory

    static let profileSections = [[name, bio], [company, location, blog], [button]]
    static let userDetailSections = [[summaryUser], [company, location, email, blog]]
    static let repoDetailSections = [[summaryRepo], [language, issues, pulls], [branches, readmeRefresh, readmeContent]]
    static let centerSections = [
        [summaryUser], [company, location, email, blog], [feedback, acknowlist, /*settings, */about]
    ]
    static let aboutSections = [[app], [author, scheme/*, ratings, invite*/]]
    static let feedbackSections = [[feedbackInput, button, feedbackNote]]
    static let searchHistorySections = [[searchHistory]]
    
    static func modifySections(with portal: Portal) -> [[Portal]] {
        switch portal {
        case .bio: return [[textView, button]]
        case .name, .company, .location, .blog: return [[textField, button]]
        default: return []
        }
    }
    
    var paramName: String? {
        switch self {
        case .name: return "name"
        case .bio: return "bio"
        case .company: return "company"
        case .location: return "location"
        case .blog: return "blog"
        default: return nil
        }
    }
    
//    func title(for user: User) -> String? {
//        // [[summaryUser], [company, location, email, blog]]
//        
//    }
    
}

extension Portal: CustomStringConvertible {
    var description: String {
        "\(self.rawValue)"
    }
}

extension Portal: PortalType {
    
    var title: String? {
        switch self {
        case .theme: return R.string.localizable.theme()
        case .feedback: return R.string.localizable.feedback()
        case .acknowlist: return R.string.localizable.acknowlist()
        case .settings: return R.string.localizable.settings()
        case .about: return R.string.localizable.about()
        case .name: return R.string.localizable.name()
        case .bio: return R.string.localizable.bio()
        case .company: return R.string.localizable.company()
        case .location: return R.string.localizable.location()
        case .email: return R.string.localizable.email()
        case .blog: return R.string.localizable.blog()
        case .author: return R.string.localizable.author()
        case .scheme: return R.string.localizable.aboutPortalSchemes()
        case .ratings: return R.string.localizable.aboutPortalRatings()
        case .invite: return R.string.localizable.aboutPortalInvite()
        case .issues: return R.string.localizable.issues()
        case .pulls: return R.string.localizable.pulls()
        case .branches: return R.string.localizable.branches()
        case .readmeRefresh: return R.string.localizable.readme()
        default: return nil
        }
    }
    
    var image: UIImage? {
        switch self {
        case .theme: return R.image.theme()
        case .feedback: return R.image.feedback()
        case .acknowlist: return R.image.acknowlist()
        case .settings: return R.image.settings()
        case .about: return R.image.about()
        case .company: return R.image.company()
        case .location: return R.image.location()
        case .email: return R.image.email()
        case .blog: return R.image.blog()
        case .language: return R.image.repo_language()
        case .issues: return R.image.repo_issues()
        case .pulls: return R.image.repo_pulls()
        case .branches: return R.image.repo_branches()
        case .readmeRefresh: return R.image.repo_readme()
        default: return nil
        }
    }
    
    var urlScheme: String? {
        switch self {
        case .feedback: return Router.urlString(host: .feedback)
        case .about: return Router.urlString(host: .about)
        case .name, .bio, .company, .location, .blog:
            return Router.urlString(host: .modify)
        case .author: return Router.urlString(host: .user)
        case .scheme: return Router.urlString(host: .scheme)
        case .theme: return Router.urlString(host: .theme)
        case .acknowlist: return Router.urlString(host: .acknowList)
        case .settings: return Router.urlString(host: .settings)
        default:
            return nil
        }
    }
    
}
