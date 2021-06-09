//
//  Href.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/15.
//

import Foundation

struct Href: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = 0
    var value: String?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        value       <- map["href"]
    }

}
