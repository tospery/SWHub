//
//  Simple.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/1.
//

import Foundation

struct Simple: ModelType {

    enum Identifier {
        case userDetail
        case userProfile
        case repoDetail
    }
    
    var id = 0
    var title: String?
    var detail: NSAttributedString?
    var icon: ImageSource?
    var indicated = true
    var identifier: Identifier?

    init() { }

    init?(map: Map) { }
    
    init(id: Int,
         icon: ImageSource? = nil,
         title: String? = nil,
         detail: NSAttributedString? = nil,
         indicated: Bool = true,
         identifier: Identifier? = nil
    ) {
        self.id = id
        self.icon = icon
        self.title = title
        self.detail = detail
        self.indicated = indicated
        self.identifier = identifier
    }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        icon            <- map["icon"]
        title           <- map["title"]
        detail          <- map["detail"]
        indicated       <- map["indicated"]
    }

}
