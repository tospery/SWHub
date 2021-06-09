//
//  Plan.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/4/22.
//

import Foundation

struct Plan: ModelType, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = 0
    var space: Int?
    var privateRepos: Int?
    var collaborators: Int?
    var name: String?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        space           <- map["space"]
        privateRepos    <- map["private_repos"]
        collaborators   <- map["collaborators"]
        name            <- map["name"]
    }
    
}
