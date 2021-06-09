//
//  ListViewController+Repos.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/30.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenReposTrending(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        self.tapCellWhenRepos(sectionItem)
    }
    
    @objc func tapCellWhenReposStars(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        self.tapCellWhenRepos(sectionItem)
    }
    
    @objc func tapCellWhenReposSearch(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        self.tapCellWhenRepos(sectionItem)
    }

    @objc func handleUserWhenReposStars(_ data: Any!) {
        let user = data as? User
        self.reactor?.username = user?.username
        MainScheduler.asyncInstance.schedule(()) { [weak self] _ -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            self.reactor?.action.onNext(.load)
            return Disposables.create {}
        }.disposed(by: self.disposeBag)
    }
    
    func tapCellWhenRepos(_ sectionItem: SectionItem) {
        switch sectionItem {
        case let .repo(item):
            guard let repo = item.model as? Repo else { return }
            self.navigator.push(
                Router.urlString(host: .repo).url!
                    .appendingPathComponent(repo.owner.username)
                    .appendingPathComponent(repo.name)
            )
        default:
            break
        }
    }

}
