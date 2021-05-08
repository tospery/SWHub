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
    let brightColor = UIColor(hex: 0xF2F2F2)!
    let dimColor = UIColor(hex: 0x000000, transparency: 0.2)!
    var primaryColor = UIColor(hex: 0x0277FF)!
    let secondaryColor = UIColor.Material.blue
    let titleColor = UIColor(hex: 0x333333)!
    let bodyColor = UIColor(hex: 0x666666)!
    let headerColor = UIColor(hex: 0xD2D2D2)!
    let footerColor = UIColor(hex: 0xB2B2B2)!
    let borderColor = UIColor(hex: 0xF4F4F4)!
    let cornerColor = UIColor(hex: 0xF4F4F4)!
    let separatorColor = UIColor(hex: 0xF2F2F2)!
    let indicatorColor = UIColor.Material.grey600
    let special1Color = UIColor(hex: 0xE82220)!
    let special2Color = UIColor(hex: 0xFF6161)!
    let special3Color = UIColor(hex: 0xE3E3E3)!
    let special4Color = UIColor(hex: 0xE3E3E3)!
    let special5Color = UIColor(hex: 0xE3E3E3)!
    let special6Color = UIColor(hex: 0xE3E3E3)!
    let special7Color = UIColor(hex: 0xE3E3E3)!
    let special8Color = UIColor(hex: 0xE3E3E3)!
    let special9Color = UIColor(hex: 0xE3E3E3)!
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
    
    init(color: UIColor?) {
        guard let color = color else { return }
        self.primaryColor = color
    }
}

struct DarkTheme: Theme {
    let backgroundColor = UIColor.Material.black
    let foregroundColor = UIColor.Material.white
    let lightColor = UIColor.Material.grey900
    let darkColor = UIColor.Material.grey100
    let brightColor = UIColor.Material.grey300
    let dimColor = UIColor.Material.grey700
    var primaryColor = UIColor.Material.orange
    let secondaryColor = UIColor.Material.red
    let titleColor = UIColor.Material.red
    let bodyColor = UIColor.Material.red
    let headerColor = UIColor(hex: 0xD2D2D2)!
    let footerColor = UIColor(hex: 0xD2D2D2)!
    let borderColor = UIColor.Material.red
    let cornerColor = UIColor(hex: 0xF4F4F4)!
    let separatorColor = UIColor.Material.red
    let indicatorColor = UIColor.Material.red
    let special1Color = UIColor.Material.red
    let special2Color = UIColor.Material.red
    let special3Color = UIColor.Material.red
    let special4Color = UIColor.Material.red
    let special5Color = UIColor.Material.red
    let special6Color = UIColor(hex: 0xE3E3E3)!
    let special7Color = UIColor(hex: 0xE3E3E3)!
    let special8Color = UIColor(hex: 0xE3E3E3)!
    let special9Color = UIColor(hex: 0xE3E3E3)!
    let barStyle = UIBarStyle.default
    let statusBarStyle = UIStatusBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
    let blurStyle = UIBlurEffect.Style.extraLight
    
    init(color: UIColor?) {
        guard let color = color else { return }
        self.primaryColor = color
    }
}

extension ThemeType: ThemeTypeCompatible {
    public var theme: Theme {
        switch self {
        case let .light(color): return LightTheme.init(color: color)
        case let .dark(color): return DarkTheme.init(color: color)
        }
    }
}

enum ColorTheme: Int {
    case red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green, lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray

    static let allValues = [red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green, lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray]

    var color: UIColor {
        switch self {
        case .red: return UIColor.Material.red
        case .pink: return UIColor.Material.pink
        case .purple: return UIColor.Material.purple
        case .deepPurple: return UIColor.Material.deepPurple
        case .indigo: return UIColor.Material.indigo
        case .blue: return UIColor.Material.blue
        case .lightBlue: return UIColor.Material.lightBlue
        case .cyan: return UIColor.Material.cyan
        case .teal: return UIColor.Material.teal
        case .green: return UIColor.Material.green
        case .lightGreen: return UIColor.Material.lightGreen
        case .lime: return UIColor.Material.lime
        case .yellow: return UIColor.Material.yellow
        case .amber: return UIColor.Material.amber
        case .orange: return UIColor.Material.orange
        case .deepOrange: return UIColor.Material.deepOrange
        case .brown: return UIColor.Material.brown
        case .gray: return UIColor.Material.grey
        case .blueGray: return UIColor.Material.blueGrey
        }
    }

    var colorDark: UIColor {
        switch self {
        case .red: return UIColor.Material.red900
        case .pink: return UIColor.Material.pink900
        case .purple: return UIColor.Material.purple900
        case .deepPurple: return UIColor.Material.deepPurple900
        case .indigo: return UIColor.Material.indigo900
        case .blue: return UIColor.Material.blue900
        case .lightBlue: return UIColor.Material.lightBlue900
        case .cyan: return UIColor.Material.cyan900
        case .teal: return UIColor.Material.teal900
        case .green: return UIColor.Material.green900
        case .lightGreen: return UIColor.Material.lightGreen900
        case .lime: return UIColor.Material.lime900
        case .yellow: return UIColor.Material.yellow900
        case .amber: return UIColor.Material.amber900
        case .orange: return UIColor.Material.orange900
        case .deepOrange: return UIColor.Material.deepOrange900
        case .brown: return UIColor.Material.brown900
        case .gray: return UIColor.Material.grey900
        case .blueGray: return UIColor.Material.blueGrey900
        }
    }

    var title: String {
        switch self {
        case .red: return "Red"
        case .pink: return "Pink"
        case .purple: return "Purple"
        case .deepPurple: return "Deep Purple"
        case .indigo: return "Indigo"
        case .blue: return "Blue"
        case .lightBlue: return "Light Blue"
        case .cyan: return "Cyan"
        case .teal: return "Teal"
        case .green: return "Green"
        case .lightGreen: return "Light Green"
        case .lime: return "Lime"
        case .yellow: return "Yellow"
        case .amber: return "Amber"
        case .orange: return "Orange"
        case .deepOrange: return "Deep Orange"
        case .brown: return "Brown"
        case .gray: return "Gray"
        case .blueGray: return "Blue Gray"
        }
    }
}
