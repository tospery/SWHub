//
//  Commit2.swift
//  SWHub
//
//  Created by liaoya on 2021/5/14.
//

import Foundation

struct Commit: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = ""
    var url: String?
    var label: String?
    var ref: String?
    var repo: Repo?
    var user: User?
    
    var sha: String {
        self.id
    }

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id      <- map["sha"]
        url     <- map["url"]
        label   <- map["label"]
        ref     <- map["ref"]
        repo    <- map["repo"]
        user    <- map["user"]
    }

}
