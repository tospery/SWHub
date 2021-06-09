//
//  ListViewReactor+Search.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import Foundation

extension ListViewReactor {
    
    @objc func loadModelsWhenSearchHistory(_ param: Any!) -> Any {
        Observable<[[ModelType]]>.create { observer -> Disposable in
            let history = SearchHistory.cachedObject()
            observer.onNext(history != nil ? [[history!]] : [])
            observer.onCompleted()
            return Disposables.create { }
        }
    }
    
    @objc func reduceWhenSearchHistory(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        if type != .initial {
            return state
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                .searchHistory(.init($0))
            })
        })
        return state
    }

}
