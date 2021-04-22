//
//  UIColorExt.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/30.
//

import UIKit

extension UIColor {

    static var background: UIColor {
        return themeService.type.associatedObject.backgroundColor
    }

    static var foreground: UIColor {
        return themeService.type.associatedObject.foregroundColor
    }

    static var light: UIColor {
        return themeService.type.associatedObject.lightColor
    }

    static var dark: UIColor {
        return themeService.type.associatedObject.darkColor
    }

    static var dim: UIColor {
        return themeService.type.associatedObject.dimColor
    }

    static var bright: UIColor {
        return themeService.type.associatedObject.brightColor
    }

    static var primary: UIColor {
        return themeService.type.associatedObject.primaryColor
    }

    static var secondary: UIColor {
        return themeService.type.associatedObject.secondaryColor
    }

    static var headline: UIColor {
        return themeService.type.associatedObject.headlineColor
    }

    static var footnote: UIColor {
        return themeService.type.associatedObject.footnoteColor
    }

    static var title: UIColor {
        return themeService.type.associatedObject.titleColor
    }

    static var caption: UIColor {
        return themeService.type.associatedObject.captionColor
    }

    static var body: UIColor {
        return themeService.type.associatedObject.bodyColor
    }

    static var border: UIColor {
        return themeService.type.associatedObject.borderColor
    }

    static var separator: UIColor {
        return themeService.type.associatedObject.separatorColor
    }

    static var indicator: UIColor {
        return themeService.type.associatedObject.indicatorColor
    }
    
    static var special1: UIColor {
        return themeService.type.associatedObject.special1Color
    }

    static var special2: UIColor {
        return themeService.type.associatedObject.special2Color
    }

    static var special3: UIColor {
        return themeService.type.associatedObject.special3Color
    }

}
