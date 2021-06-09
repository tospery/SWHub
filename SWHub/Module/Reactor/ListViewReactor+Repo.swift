//
//  ListViewReactor+Repo.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/21.
//

import Foundation

extension ListViewReactor {
    
    @objc func loadWhenRepo() -> Any {
        Observable<Data>.zip([
            self.provider.repo(
                username: self.username, reponame: self.reponame
            )
            .asObservable()
            .map { Data.init(repo: $0) },
            self.provider.readme(
                username: self.username, reponame: self.reponame, ref: nil
            )
            .asObservable()
            .map { Data.init(readme: $0) },
            self.provider.branches(
                username: self.username, reponame: self.reponame, page: self.pageIndex
            )
            .asObservable()
            .map { Data.init(branches: $0) },
            self.provider.pulls(
                username: self.username, reponame: self.reponame, state: self.stateP, page: self.pageIndex
            )
            .asObservable()
            .map { Data.init(pulls: $0) }
        ])
        .map {
            Data.init(
                repo: $0[0].repo, readme: $0[1].readme, branches: $0[2].branches, pulls: $0[3].pulls
            )
        }
        .map(Mutation.setData)
    }
    
    // swiftlint:disable cyclomatic_complexity
    @objc func reduceWhenRepo(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        if type != .data {
            return state
        }
        state.models = Portal.repoDetailSections.map {
            $0.filter {
                switch $0 {
                case .summaryRepo: return state.data.repo != nil
                case .readmeContent: return state.data.readme != nil
                default: return true
                }
            }
        }
        .map {
            $0.map { portal -> ModelType in
                switch portal {
                case .summaryRepo: return state.data.repo!
                case .readmeContent: return state.data.readme!
                case .readmeRefresh: return BaseModel.init(portal)
                default:
                    return Simple.init(
                        id: portal.rawValue,
                        icon: portal.image?.template,
                        title: portal.title,
                        identifier: .repoDetail
                    )
                }
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                if $0 is Repo {
                    return .summaryRepo(.init($0))
                } else if $0 is Readme {
                    return .readmeContent(.init($0))
                } else if $0 is BaseModel {
                    return .readmeRefresh(.init($0))
                } else {
                    return .simple(.init($0))
                }
            })
        })
        return state
    }
    // swiftlint:enable cyclomatic_complexity

}
