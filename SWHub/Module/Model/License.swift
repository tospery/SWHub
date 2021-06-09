//
//  License.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/11.
//

import Foundation

struct License: ModelType, Subjective, Eventable {

    enum Event {
    }
    
    var id = ""
    var key: String?
    var name: String?
    var spdxId: String?
    var url: String?
    
    var nodeId: String {
        self.id
    }

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["node_id"]
        key         <- map["key"]
        name        <- map["name"]
        spdxId      <- map["spdx_id"]
        url         <- map["url"]
    }

}
