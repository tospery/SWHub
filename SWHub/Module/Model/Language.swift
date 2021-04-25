//
//  Language.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

struct Language: ModelType, Subjective, Eventable {
    
    enum Event {
    }

    var id: String?
    var name: String?
    
    var urlParam: String? {
        self.id
    }
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id      <- map["urlParam"]
        name    <- map["name"]
    }
    
}
