//
//  ListViewReactor+Scheme.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/24.
//

import Foundation

extension ListViewReactor {
    
    @objc func reduceWhenScheme(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        state.models = [
            Router.exportedURLSchemes()
                .map { (name, pattern, _) -> KVTuple in
                    (
                        key: R.string.localizable.schemeOpen(name),
                        value: pattern
                    )
                }
                .map { BaseModel.init($0) }
        ]
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                .scheme(.init($0))
            })
        })
        return state
    }

}
