//
//  ListViewController+About.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenAbout(_ data: Any) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .simple(item):
            guard let simple = item.model as? Simple else { return }
            guard let portal = Portal.init(rawValue: simple.id) else { return }
            guard let urlScheme = portal.urlScheme else { return }
            switch portal {
            case .author:
                self.navigator.push(
                    urlScheme.url!.appendingPathComponent(Author.username)
                )
            default:
                self.navigator.push(urlScheme)
            }
        default:
            break
        }
    }

}
