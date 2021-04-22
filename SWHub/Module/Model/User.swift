//
//  User.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct User: ModelType, Identifiable, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = ""
    var token: String?
    var username: String?
    
    var isLogined: Bool {
        if self.id.isEmpty ||
            self.token?.isEmpty ?? true ||
            self.username?.isEmpty ?? true {
            return false
        }
        return true
    }
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        token               <- map["token"]
        username            <- map["username"]
    }
    
    static func update(_ user: User?) {
        if let old = Self.current {
            if let new = user {
                if let oldJSONString = old.toJSONString(),
                   let newJSONString = new.toJSONString(),
                   oldJSONString != newJSONString {
                    // 更新
                    log("用户更新: \(new)")
                    SWHub.update(User.self, new)
                }
            } else {
                // 退出
                log("用户退出: \(old)")
                SWHub.update(User.self, nil)
            }
        } else {
            if let new = user {
                // 登录
                log("用户登录: \(new)")
                SWHub.update(User.self, new)
            }
        }
    }
    
}
