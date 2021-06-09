//
//  Router+Model.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import Toast_Swift
import SideMenu
import PopupDialog

extension Router {
    
    static func model(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        self.toast(provider, navigator)
        self.alert(provider, navigator)
        self.sheet(provider, navigator)
        self.popup(provider, navigator)
    }
    
    static func toast(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.handle(self.urlPattern(host: .toast)) { url, _, _ -> Bool in
            guard let window = AppDependency.shared.window else { return false }
            if let message = url.queryParameters[Parameter.message] {
                window.makeToast(message)
            } else if let active = url.queryParameters[Parameter.active] {
                (active.bool ?? false) ? window.makeToastActivity(.center) : window.hideToastActivity()
            } else {
                return false
            }
            return true
        }
    }
    
    static func alert(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.handle(self.urlPattern(host: .alert)) { url, _, context -> Bool in
            guard let top = UIViewController.topMost else { return false }
            let title = url.queryParameters[Parameter.title]
            let message = url.queryParameters[Parameter.message]
            if title?.isEmpty ?? true && message?.isEmpty ?? true {
                return false
            }
            
            let ctx = context as? [String: Any]
            let observer = ctx?[Parameter.observer] as? AnyObserver<Any>
            
            var result: AlertActionType!
            let alert = PopupDialog.init(
                title: title,
                message: message,
                image: nil,
                buttonAlignment: .horizontal,
                transitionStyle: .zoomIn,
                preferredWidth: 200,
                tapGestureDismissal: false,
                panGestureDismissal: false,
                hideStatusBar: false) {
                observer?.onNext(result as Any)
                observer?.onCompleted()
            }
            var buttons = [PopupDialogButton].init()
            for action in ctx?[Parameter.actions] as? [AlertActionType] ?? [] {
                switch action.style {
                case .cancel:
                    buttons.append(CancelButton.init(title: action.title ?? "") {
                        result = action
                    })
                case .default:
                    buttons.append(DefaultButton.init(title: action.title ?? "") {
                        result = action
                    })
                case .destructive:
                    buttons.append(DestructiveButton.init(title: action.title ?? "") {
                        result = action
                    })
                @unknown default:
                    continue
                }
            }
            alert.addButtons(buttons)
            top.present(alert, animated: true, completion: nil)
            return true
        }
    }
    
    static func sheet(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
    }
    
    static func popup(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.handle(self.urlPattern(host: .popup)) { url, values, context -> Bool in
            guard let value = values["type"] as? String else { return false }
            guard let popup = Path.init(rawValue: value) else { return false }
            switch popup {
            case .menu:
                return self.popupMenu(provider, navigator, self.parameters(url, values, context))
            default:
                return false
            }
        }
    }
    
    static func popupMenu(
        _ provider: SWFrame.ProviderType, _ navigator: NavigatorType, _ parameters: [String: Any]?
    ) -> Bool {
        guard let top = UIViewController.topMost else { return false }
        let reactor = MenuViewReactor.init(provider, parameters)
        let controller = MenuViewController.init(navigator, reactor)
        let menu = SideMenuNavigationController.init(rootViewController: controller)
        menu.leftSide = true
        menu.settings.presentationStyle = .menuSlideIn
        menu.settings.presentationStyle.presentingEndAlpha = 0.7
        menu.settings.menuWidth = (UIScreen.width * SWHub.Metric.menuScale).flat
        top.present(menu, animated: true, completion: nil)
        return true
    }
    
}
