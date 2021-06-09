//
//  BaseUser.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/11.
//

import Foundation

struct BaseUser: ModelType, Subjective, Eventable {

    enum Event {
    }

    var id = 0
    var username: String?
    var href: String?
    var avatar: String?

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        username    <- map["username"]
        href        <- map["href"]
        avatar      <- map["avatar"]
    }

}
