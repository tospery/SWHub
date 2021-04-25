//
//  User.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct User: ModelType, Subjective, Eventable {
    
    enum Event {
    }

    var id: Int?
    var siteAdmin: Bool?
    var twoFactorAuthentication: Bool?
    var followers: Int?
    var following: Int?
    var diskUsage: Int?
    var privateGists: Int?
    var publicGists: Int?
    var publicRepos: Int?
    var collaborators: Int?
    var ownedPrivateRepos: Int?
    var totalPrivateRepos: Int?
    var avatarUrl: String?
    var bio: String?
    var blog: String?
    var company: String?
    var createdAt: String?
    var email: String?
    var eventsUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var gravatarId: String?
    var htmlUrl: String?
    var location: String?
    var login: String?
    var name: String?
    var nodeId: String?
    var organizationsUrl: String?
    var receivedEventsUrl: String?
    var reposUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var type: String?
    var updatedAt: String?
    var url: String?
    var hireable: String?
    var twitterUsername: String?
    var username: String?
    var avatar: String?
    var sponsorUrl: String?
    var plan: Plan?
    var repos: [Repo]?
    
    var isValid: Bool {
        self.id ?? 0 != 0 &&
            self.login?.isEmpty ?? true == false
    }
    
    init() { }

    init?(map: Map) { }

    // swiftlint:disable function_body_length
    mutating func mapping(map: Map) {
        id                      <- map["id"]
        avatarUrl               <- map["avatar_url"]
        bio                     <- map["bio"]
        blog                    <- map["blog"]
        collaborators           <- map["collaborators"]
        company                 <- map["company"]
        createdAt               <- map["created_at"]
        diskUsage               <- map["disk_usage"]
        email                   <- map["email"]
        eventsUrl               <- map["events_url"]
        followers               <- map["followers"]
        followersUrl            <- map["followers_url"]
        following               <- map["following"]
        followingUrl            <- map["following_url"]
        gistsUrl                <- map["gists_url"]
        gravatarId              <- map["gravatar_id"]
        hireable                <- map["hireable"]
        htmlUrl                 <- map["html_url"]
        location                <- map["location"]
        login                   <- map["login"]
        name                    <- map["name"]
        nodeId                  <- map["node_id"]
        organizationsUrl        <- map["organizations_url"]
        ownedPrivateRepos       <- map["owned_private_repos"]
        plan                    <- map["plan"]
        privateGists            <- map["private_gists"]
        publicGists             <- map["public_gists"]
        publicRepos             <- map["public_repos"]
        receivedEventsUrl       <- map["received_events_url"]
        reposUrl                <- map["repos_url"]
        siteAdmin               <- map["site_admin"]
        starredUrl              <- map["starred_url"]
        subscriptionsUrl        <- map["subscriptions_url"]
        totalPrivateRepos       <- map["total_private_repos"]
        twitterUsername         <- map["twitter_username"]
        twoFactorAuthentication <- map["two_factor_authentication"]
        type                    <- map["type"]
        updatedAt               <- map["updated_at"]
        url                     <- map["url"]
        username                <- map["username"]
        avatar                  <- map["avatar"]
        sponsorUrl              <- map["sponsorUrl"]
        repos                   <- map["repo"]
    }
    // swiftlint:enable function_body_length
    
    static func update(_ user: User?) {
        if let old = Self.current {
            if let new = user {
                if old != new {
                    log("用户更新: \(new)")
                    SWHub.update(User.self, new)
                }
            } else {
                log("用户退出: \(old)")
                SWHub.update(User.self, nil)
            }
        } else {
            if let new = user {
                log("用户登录: \(new)")
                SWHub.update(User.self, new)
            }
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        var leftJSON = lhs.toJSON()
        leftJSON.removeValue(forKey: "token")
        leftJSON.removeValue(forKey: "nowtime")
        var rightJSON = rhs.toJSON()
        rightJSON.removeValue(forKey: "token")
        rightJSON.removeValue(forKey: "nowtime")
        let leftValue = leftJSON.jsonString()?.sorted()
        let rightValue = rightJSON.jsonString()?.sorted()
        return leftValue == rightValue
    }
    
}
