//
//  BaseRepo.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/11.
//

import Foundation

struct BaseRepo: ModelType, Subjective, Eventable {
    
    enum Event {
    }

    var id = 0
    var url: String?
    var name: String?
    var desc: String?

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        url         <- map["url"]
        name        <- map["name"]
        desc        <- map["description"]
    }

}
