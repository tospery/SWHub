//
//  List+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/5.
//

import Foundation

extension List: ListCompatible {
    public func count(map: Map) -> Int {
        var count: Int?
        count   <- map["total_count"]
        return count ?? 0
    }
}
