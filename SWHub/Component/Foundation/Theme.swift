//
//  Theme.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct LightTheme: Theme {
    let backgroundColor = UIColor.Material.white
    let foregroundColor = UIColor.Material.black
    let lightColor = UIColor(hex: 0xF6F6F6)!
    let darkColor = UIColor.Material.grey900
    let brightColor = UIColor.Material.grey900
    let dimColor = UIColor(hex: 0x000000, transparency: 0.2)!
    let primaryColor = UIColor(hex: 0x0277FF)!
    let secondaryColor = UIColor.Material.blue
    let titleColor = UIColor(hex: 0x333333)!
    let bodyColor = UIColor(hex: 0x666666)!
    let headerColor = UIColor(hex: 0xD2D2D2)!
    let footerColor = UIColor(hex: 0xD2D2D2)!
    let borderColor = UIColor(hex: 0xF4F4F4)!
    let separatorColor = UIColor(hex: 0xF2F2F2)!
    let indicatorColor = UIColor.Material.grey600
    let special1Color = UIColor(hex: 0xE82220)!
    let special2Color = UIColor(hex: 0xFF6161)!
    let special3Color = UIColor(hex: 0xE3E3E3)!
    let special4Color = UIColor(hex: 0xE3E3E3)!
    let special5Color = UIColor(hex: 0xE3E3E3)!
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
}

struct DarkTheme: Theme {
    let backgroundColor = UIColor.Material.black
    let foregroundColor = UIColor.Material.white
    let lightColor = UIColor.Material.grey900
    let darkColor = UIColor.Material.grey100
    let brightColor = UIColor.Material.grey300
    let dimColor = UIColor.Material.grey700
    let primaryColor = UIColor.Material.red
    let secondaryColor = UIColor.Material.red
    let titleColor = UIColor.Material.red
    let bodyColor = UIColor.Material.red
    let headerColor = UIColor(hex: 0xD2D2D2)!
    let footerColor = UIColor(hex: 0xD2D2D2)!
    let borderColor = UIColor.Material.red
    let separatorColor = UIColor.Material.red
    let indicatorColor = UIColor.Material.red
    let special1Color = UIColor.Material.red
    let special2Color = UIColor.Material.red
    let special3Color = UIColor.Material.red
    let special4Color = UIColor.Material.red
    let special5Color = UIColor.Material.red
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
}

extension ThemeType: ThemeTypeCompatible {
    public var theme: Theme {
        switch self {
        case .light: return LightTheme.init()
        case .dark: return DarkTheme.init()
        }
    }
}
