//
//  Branch.swift
//  SWHub
//
//  Created by liaoya on 2021/5/14.
//

import Foundation

struct Branch: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = ""
    var `protected`: Bool?
    var commit: Commit?

    var name: String {
        self.id
    }
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["name"]
        `protected`     <- map["protected"]
        commit          <- map["commit"]
    }

}
