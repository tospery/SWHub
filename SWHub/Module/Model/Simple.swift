//
//  Simple.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/1.
//

import Foundation

struct Simple: ModelType {

    var id = 0
    var title: String?
    var detail: NSAttributedString?
    var icon: ImageSource?
    var indicated = true

    init() { }
    
    init(id: Int,
         title: String?,
         detail: NSAttributedString? = nil,
         icon: ImageSource? = nil,
         indicated: Bool = true
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.indicated = indicated
        self.icon = icon
    }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        icon            <- map["icon"]
        title           <- map["title"]
        detail          <- map["detail"]
        indicated       <- map["indicated"]
    }

}
