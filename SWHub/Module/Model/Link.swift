//
//  Link.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/15.
//

import Foundation

struct Link: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = ""
    var git: String?
    var html: String?
    var myself: String?
    var comments: Href?
    var commits: Href?
    var issue: Href?
    var reviewComment: Href?
    var reviewComments: Href?
    var statuses: Href?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        git                 <- map["git"]
        html                <- map["html"]
        myself              <- map["self"]
        comments            <- map["comments"]
        commits             <- map["commits"]
        issue               <- map["issue"]
        reviewComment       <- map["review_comment"]
        reviewComments      <- map["review_comments"]
        statuses            <- map["statuses"]
    }

}
