//
//  SearchHistory.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import Foundation

struct SearchHistory: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = ""
    var words = [String].init()
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        words       <- map["words"]
    }

}
