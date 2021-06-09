//
//  Issue+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/18.
//

import Foundation
import DateToolsSwift_JX

extension Issue {
    
    var timeAgoSinceNow: String {
        guard let string = self.updatedAt else { return "" }
        guard let date = Date.init(iso8601: string) else { return "" }
        return date.timeAgoSinceNow
    }
    
}
