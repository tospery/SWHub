//
//  IntExt.swift
//  SWHub
//
//  Created by liaoya on 2021/4/26.
//

import Foundation

public extension Int {
    
    var formatted: String {
        let sign = ((self < 0) ? "-" : "" )
        if self < 1000 {
            return "\(sign)\(self)"
        }
        let num = fabs(self.double)
        let exp: Int = Int(log10(num) / 3.0 )
        let units: [String] = ["K", "M", "G", "T", "P", "E"]
        let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10
        return "\(sign)\(roundedNum)\(units[exp-1])"
    }
    
}
