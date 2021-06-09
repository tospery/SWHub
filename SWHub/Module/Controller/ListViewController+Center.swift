//
//  ListViewController+Center.swift
//  SWHub
//
//  Created by liaoya on 2021/5/24.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenCenter(_ data: Any) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .simple(item):
            guard let simple = item.model as? Simple else { return }
            guard let portal = Portal.init(rawValue: simple.id) else { return }
            guard let urlScheme = portal.urlScheme else { return }
            switch portal {
            case .feedback:
                self.navigator.forward(
                    urlScheme.url!.appendingPathComponent(self.reactor?.currentState.user?.username ?? "")
                )
            case .acknowlist:
                self.navigator.present(urlScheme, wrap: NavigationController.self)
            default:
                self.navigator.push(urlScheme)
            }
        case .summaryUser:
            self.navigator.forward(Router.urlString(host: .profile))
        default:
            break
        }
    }

}
