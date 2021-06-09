//
//  ListViewReactor+Profile.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/22.
//

import Foundation

extension ListViewReactor {
    
    @objc func reduceWhenProfile(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        state.models = Portal.profileSections.map {
            $0.map {
                if $0 == .button {
                    return BaseModel.init($0)
                }
                return Simple.init(id: $0.rawValue, title: $0.title, identifier: .userProfile)
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                ($0 is BaseModel) ? .logout(.init($0)) : .simple(.init($0))
            })
        })
        return state
    }

}
