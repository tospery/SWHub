//
//  Token.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/10.
//

import Foundation

struct Token: ModelType {

    var id = 0
    var accessToken: String?
    var tokenType: String?
    var scope: String?

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        accessToken     <- map["access_token"]
        tokenType       <- map["token_type"]
        scope           <- map["scope"]
    }

}
