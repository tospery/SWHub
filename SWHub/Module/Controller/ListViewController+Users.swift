//
//  ListViewController+Users.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/30.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenUsersTrending(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .trendingUser(item):
            guard let user = item.model as? User else { return }
            self.navigator.push(
                Router.urlString(host: .user).url!
                    .appendingPathComponent(user.username)
            )
        default:
            break
        }
    }
    
    @objc func tapCellWhenUsersSearch(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .searchUser(item):
            guard let user = item.model as? User else { return }
            self.navigator.push(
                Router.urlString(host: .user).url!
                    .appendingPathComponent(user.username)
            )
        default:
            break
        }
    }
    
}
