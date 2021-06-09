//
//  String+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/24.
//

import Foundation

extension String {
    
    var method: String {
        self.replacingOccurrences(of: "/", with: " ").camelCased
    }
    
}
