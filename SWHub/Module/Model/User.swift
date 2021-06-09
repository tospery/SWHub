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
    
    // base
    var id = 0
    var href: String?
    // trending
    var sponsorUrl: String?
    var url: String?
    var repo: BaseRepo?
    // other
    var siteAdmin: Bool?
    var twoFactorAuthentication: Bool?
    var followers = 0
    var following = 0
    var diskUsage = 0
    var privateGists = 0
    var publicGists = 0
    var publicRepos = 0
    var collaborators = 0
    var ownedPrivateRepos = 0
    var totalPrivateRepos = 0
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
    var nodeId: String?
    var organizationsUrl: String?
    var receivedEventsUrl: String?
    var reposUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var type: String?
    var updatedAt: String?
    var hireable: String?
    var twitterUsername: String?
    var plan: Plan?
    var token: String?
    // 合并字段
    var ranking = 0
    var username = ""           // username|login
    var nickname: String?       // name
    var avatar: String?         // avatar|avatar_url

    init() { }

    init?(map: Map) { }
    
    // swiftlint:disable function_body_length
    mutating func mapping(map: Map) {
        id                      <- map["id"]
        href                    <- map["href"]
        nickname                <- map["name"]
        ranking                 <- map["ranking"]
        repo                    <- map["repo"]
        sponsorUrl              <- map["sponsorUrl"]
        url                     <- map["url"]
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
        token                   <- map["token"]
        username                <- map["username"]
        if username.isEmpty {
            username            <- map["login"]
        }
        avatar                  <- map["avatar"]
        if avatar?.isEmpty ?? true {
            avatar              <- map["avatar_url"]
        }
    }
    // swiftlint:enable function_body_length
    
    static func update(_ user: User?, reactive: Bool) {
        if let old = Self.current {
            if let new = user {
                if old != new {
                    log("用户更新: \(new)")
                    Subjection.update(self, new, reactive)
                } else {
                    log("相同用户，不需要处理！！！")
                }
            } else {
                log("用户退出: \(old)")
                Subjection.update(self, nil, reactive)
            }
        } else {
            if let new = user {
                log("用户登录: \(new)")
                Subjection.update(self, new, reactive)
            } else {
                log("用户已经退出，不需要处理！！！")
            }
        }
    }
    
//    static func == (lhs: User, rhs: User) -> Bool {
//        var leftJSON = lhs.toJSON()
//        leftJSON.removeValue(forKey: "token")
//        var rightJSON = rhs.toJSON()
//        rightJSON.removeValue(forKey: "token")
//        let leftValue = leftJSON.jsonString()?.sorted()
//        let rightValue = rightJSON.jsonString()?.sorted()
//        return leftValue == rightValue
//    }

}
