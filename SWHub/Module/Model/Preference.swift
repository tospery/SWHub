//
//  Preference.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct Preference: ModelType, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = ""
    var since = Since.daily
    var language: Language?
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        since       <- map["since"]
        language    <- map["language"]
    }
    
}
