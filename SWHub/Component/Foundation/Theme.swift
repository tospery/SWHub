//
//  Theme.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

let themeService = ThemeType.service(initial: .light)

/// 假设从白到黑值为：0~9
protocol Theme {
    var backgroundColor: UIColor { get }                        // 白色
    var foregroundColor: UIColor { get }                        // 黑色
    var lightColor: UIColor { get }                             // 浅色
    var darkColor: UIColor { get }                              // 深色
    var dimColor: UIColor { get }                               // 暗色
    var brightColor: UIColor { get }                            // 亮色
    var primaryColor: UIColor { get }                           // 主色（如：红色）
    var secondaryColor: UIColor { get }                         // 次色（如：蓝色）
    var headlineColor: UIColor { get }                          // 头部
    var titleColor: UIColor { get }                             // 标题
    var captionColor: UIColor { get }                           // 副标题
    var bodyColor: UIColor { get }                              // 主体
    var footnoteColor: UIColor { get }                          // 脚注
    var borderColor: UIColor { get }                            // 边框
    var separatorColor: UIColor { get }                         // 分隔条
    var indicatorColor: UIColor { get }                         // 指示器
    var special1Color: UIColor { get }                          // 特殊1
    var special2Color: UIColor { get }                          // 特殊2
    var special3Color: UIColor { get }                          // 特殊3
    var barStyle: UIBarStyle { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var blurStyle: UIBlurEffect.Style { get }
}

struct LightTheme: Theme {
    let backgroundColor = UIColor.Material.white
    let foregroundColor = UIColor.Material.black
    let lightColor = UIColor(hex: 0xF6F6F6)!
    let darkColor = UIColor.Material.grey900
    let dimColor = UIColor(hex: 0x000000, transparency: 0.2)!
    let brightColor = UIColor.Material.grey900
    let primaryColor = UIColor(hex: 0x0277FF)!
    let secondaryColor = UIColor.Material.blue
    let headlineColor = UIColor(hex: 0xABABAB)!
    let titleColor = UIColor(hex: 0x333333)!
    let captionColor = UIColor(hex: 0x999999)!
    let bodyColor = UIColor(hex: 0x666666)!
    let footnoteColor = UIColor(hex: 0xD2D2D2)!
    let borderColor = UIColor.Material.grey300
    let separatorColor = UIColor(hex: 0xF2F2F2)!
    let indicatorColor = UIColor.Material.grey600
    let special1Color = UIColor(hex: 0xE82220)!
    let special2Color = UIColor(hex: 0xFF6161)!
    let special3Color = UIColor(hex: 0xE3E3E3)!
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
}

struct DarkTheme: Theme {
    let backgroundColor = UIColor.Material.black
    let foregroundColor = UIColor.Material.white
    let lightColor = UIColor.Material.grey100
    let darkColor = UIColor.Material.grey900
    let dimColor = UIColor(hex: 0x000000, transparency: 0.2)!
    let brightColor = UIColor.Material.grey900
    let primaryColor = UIColor.Material.red
    let secondaryColor = UIColor.Material.grey900
    let headlineColor = UIColor.Material.grey700
    let titleColor = UIColor.Material.grey700
    let captionColor = UIColor.Material.grey700
    let bodyColor = UIColor.Material.grey500
    let footnoteColor = UIColor.Material.grey700
    let borderColor = UIColor.Material.grey300
    let separatorColor = UIColor.Material.grey400
    let indicatorColor = UIColor.Material.grey600
    let special1Color = UIColor.Material.deepOrange900
    let special2Color = UIColor.Material.white
    let special3Color = UIColor.Material.white
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
}

enum ThemeType: ThemeProvider {
    case light
    case dark

    var associatedObject: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        }
    }
}
