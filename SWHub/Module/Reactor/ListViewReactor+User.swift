//
//  ListViewReactor+User.swift
//  SWHub
//
//  Created by liaoya on 2021/5/25.
//

import Foundation

extension ListViewReactor {
    
    @objc func loadWhenUser() -> Any {
        self.provider.user(username: self.username)
            .asObservable()
            .map(Mutation.setUser)
    }
    
    @objc func refreshWhenUser() -> Any {
        self.provider.user(username: self.username)
            .asObservable()
            .map(Mutation.setUser)
    }
    
    @objc func reduceWhenUser(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        state.models = Portal.userDetailSections.map {
            $0.map {
                if $0 == .summaryUser {
                    return BaseModel.init((key: $0, value: false))
                }
                return Simple.init(
                    id: $0.rawValue,
                    icon: $0.image?.template,
                    indicated: false,
                    identifier: .userDetail
                )
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                ($0 is BaseModel) ? .summaryUser(.init($0)) : .simple(.init($0))
            })
        })
        return state
    }

}
