//
//  Preference.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct Preference: ModelType, Identifiable, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = ""
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
    }
    
}
