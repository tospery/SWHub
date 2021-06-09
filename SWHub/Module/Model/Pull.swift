//
//  Pull.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/15.
//

import Foundation

struct Pull: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = 0
    var activeLockReason: String?
    var assignee: String?
    var assignees: [String]?
    var authorAssociation: String?
    var autoMerge: String?
    var body: String?
    var closedAt: String?
    var commentsUrl: String?
    var commitsUrl: String?
    var createdAt: String?
    var diffUrl: String?
    var draft: Bool?
    var htmlUrl: String?
    var issueUrl: String?
    var labels: [String]?
    var locked: Bool?
    var mergeCommitSha: String?
    var mergedAt: String?
    var milestone: String?
    var nodeId: String?
    var number: Int?
    var patchUrl: String?
    var requestedReviewers: [String]?
    var requestedTeams: [String]?
    var reviewCommentUrl: String?
    var reviewCommentsUrl: String?
    var state: String?
    var statusesUrl: String?
    var title: String?
    var updatedAt: String?
    var url: String?
    var links: Link?
    var base: Commit?
    var head: Commit?
    var user: User?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id                          <- map["id"]
        links                       <- map["_links"]
        activeLockReason            <- map["active_lock_reason"]
        assignee                    <- map["assignee"]
        assignees                   <- map["assignees"]
        authorAssociation           <- map["author_association"]
        autoMerge                   <- map["auto_merge"]
        base                        <- map["base"]
        body                        <- map["body"]
        closedAt                    <- map["closed_at"]
        commentsUrl                 <- map["comments_url"]
        commitsUrl                  <- map["commits_url"]
        createdAt                   <- map["created_at"]
        diffUrl                     <- map["diff_url"]
        draft                       <- map["draft"]
        head                        <- map["head"]
        htmlUrl                     <- map["html_url"]
        issueUrl                    <- map["issue_url"]
        labels                      <- map["labels"]
        locked                      <- map["locked"]
        mergeCommitSha              <- map["merge_commit_sha"]
        mergedAt                    <- map["merged_at"]
        milestone                   <- map["milestone"]
        nodeId                      <- map["node_id"]
        number                      <- map["number"]
        patchUrl                    <- map["patch_url"]
        requestedReviewers          <- map["requested_reviewers"]
        requestedTeams              <- map["requested_teams"]
        reviewCommentUrl            <- map["review_comment_url"]
        reviewCommentsUrl           <- map["review_comments_url"]
        state                       <- map["state"]
        statusesUrl                 <- map["statuses_url"]
        title                       <- map["title"]
        updatedAt                   <- map["updated_at"]
        url                         <- map["url"]
        user                        <- map["user"]
    }

}
