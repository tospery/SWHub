//
//  Issue.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import Foundation
import DateToolsSwift

struct Issue: ModelType, Subjective, Eventable {
    
    enum Event {
    }
    
    var id: Int?
    var activeLockReason: String?
    var assignee: String?
    var assignees: [String]?
    var authorAssociation: String?
    var body: String?
    var closedAt: String?
    var comments: Int?
    var commentsUrl: String?
    var createdAt: String?
    var eventsUrl: String?
    var htmlUrl: String?
    var labels: [String]?
    var labelsUrl: String?
    var locked: Bool?
    var milestone: String?
    var nodeId: String?
    var number: Int?
    var performedViaGithubApp: String?
    var repositoryUrl: String?
    var state: String?
    var title: String?
    var updatedAt: String?
    var url: String?
    var user: User?
    
    var stateIcon: UIImage? {
        guard let state = State.init(rawValue: self.state ?? "") else {
            return nil
        }
        switch state {
        case .open: return R.image.open()
        case .closed: return R.image.resolved()
        default: return nil
        }
    }
    
    var timeAgoSinceNow: String {
        guard let string = self.updatedAt else { return "" }
        guard let date = Date.init(iso8601: string) else { return "" }
        return date.timeAgoSinceNow
    }
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        activeLockReason        <- map["active_lock_reason"]
        assignee                <- map["assignee"]
        assignees               <- map["assignees"]
        authorAssociation       <- map["author_association"]
        body                    <- map["body"]
        closedAt                <- map["closed_at"]
        comments                <- map["comments"]
        commentsUrl             <- map["comments_url"]
        createdAt               <- map["created_at"]
        eventsUrl               <- map["events_url"]
        htmlUrl                 <- map["html_url"]
        id                      <- map["id"]
        labels                  <- map["labels"]
        labelsUrl               <- map["labels_url"]
        locked                  <- map["locked"]
        milestone               <- map["milestone"]
        nodeId                  <- map["node_id"]
        number                  <- map["number"]
        performedViaGithubApp   <- map["performed_via_github_app"]
        repositoryUrl           <- map["repository_url"]
        state                   <- map["state"]
        title                   <- map["title"]
        updatedAt               <- map["updated_at"]
        url                     <- map["url"]
        user                    <- map["user"]
    }

}
