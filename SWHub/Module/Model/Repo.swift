//
//  Repo.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

struct Repo: ModelType, Subjective, Eventable {
    
    enum Event {
    }

    var id: Int?
    var url: String?
    var author: String?
    var avatar: String?
    var currentPeriodStars: Int?
    var descriptionField: String?
    var forks: Int?
    var language: String?
    var languageColor: String?
    var name: String?
    var stars: Int?
    var users: [User]?
    
    var isValid: Bool {
        self.author?.isEmpty ?? true == false &&
            self.name?.isEmpty ?? true == false &&
            self.url?.isEmpty ?? true == false
    }
    
    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        url                 <- map["url"]
        author              <- map["author"]
        avatar              <- map["avatar"]
        currentPeriodStars  <- map["currentPeriodStars"]
        descriptionField    <- map["description"]
        forks               <- map["forks"]
        language            <- map["language"]
        languageColor       <- map["languageColor"]
        name                <- map["name"]
        stars               <- map["stars"]
        users               <- map["builtBy"]
    }
    
}
