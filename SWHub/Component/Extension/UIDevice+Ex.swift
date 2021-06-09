//
//  UIDevice+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/20.
//

import Foundation

extension UIDevice.Kind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ipod: return "iPod"
        case .iphone: return "iPhone"
        case .ipad: return "iPad"
        case .simulator: return "simulator"
        }
    }
}
