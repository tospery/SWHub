//
//  FeedbackResponse.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import Foundation

struct FeedbackResponse: ModelType {

    var id = 0
    var state: String?
    
    var isValid: Bool {
        self.id != 0 && self.state == "open"
    }

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        state           <- map["state"]
    }

}
