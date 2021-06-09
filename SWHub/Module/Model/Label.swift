//
//  Label.swift
//  SWHub
//
//  Created by liaoya on 2021/5/18.
//

import Foundation

struct Label: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = 0
    var color: String?
    var `default`: Bool?
    var desc: String?
    var name: String?
    var nodeId: String?
    var url: String?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        color               <- map["color"]
        `default`           <- map["default"]
        desc                <- map["description"]
        name                <- map["name"]
        nodeId              <- map["node_id"]
        url                 <- map["url"]
    }

}
