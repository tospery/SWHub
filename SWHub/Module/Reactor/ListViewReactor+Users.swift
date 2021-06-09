//
//  ListViewReactor+Users.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/30.
//

import Foundation

extension ListViewReactor {
    
    @objc func loadModelsWhenUsersTrending(_ param: Any!) -> Any {
        return Observable<[[ModelType]]>.create { observer -> Disposable in
            self.provider.developers(
                language: self.currentState.language,
                since: self.currentState.since
            ).asObservable()
            .map { users -> [[ModelType]] in
                return [users.enumerated().map { iterator -> User in
                    var object = iterator.element
                    object.ranking = iterator.offset
                    return object
                }]
            }
            .subscribe(observer)
            .disposed(by: self.disposeBag)
            return Disposables.create { }
        }
    }
    
    @objc func loadModelsWhenUsersSearch(_ param: Any!) -> Any {
        guard let page = param as? Int else { return Observable<[[ModelType]]>.empty() }
        return Observable<[[ModelType]]>.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create { } }
            self.provider.searchUsers(
                keyword: self.keyword, sort: self.sort, order: self.order, page: page
            ).asObservable()
            .map { [$0] }
            .subscribe(observer).disposed(by: self.disposeBag)
            return Disposables.create { }
        }
    }
    
    @objc func reduceWhenUsersTrending(_ param1: Any!, _ param2: Any!) -> Any {
        guard let state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        return self.reduceWhenUsers(state, type)
    }
    
    @objc func reduceWhenUsersSearch(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        if type == .append {
            var models = state.models[0]
            models.append(contentsOf: state.additions[0])
            state.models = [models]
            var items = state.sections[0].items
            items.append(contentsOf: state.additions[0].map {
                .searchUser(.init($0))
            })
            state.sections = [
                .sectionItems(header: "", items: items)
            ]
        } else {
            state.sections = (state.models.count == 0 ? [] : state.models.map {
                .sectionItems(header: "", items: $0.map {
                    .searchUser(.init($0))
                })
            })
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        return state
    }
    
    func reduceWhenUsers(_ state: State, _ mutationType: MutationType) -> State {
        var state = state
        if mutationType == .append {
            var models = state.models[0]
            models.append(contentsOf: state.additions[0])
            state.models = [models]
            var items = state.sections[0].items
            items.append(contentsOf: state.additions[0].map {
                .trendingUser(.init($0))
            })
            state.sections = [
                .sectionItems(header: "", items: items)
            ]
        } else {
            state.sections = (state.models.count == 0 ? [] : state.models.map {
                .sectionItems(header: "", items: $0.map {
                    .trendingUser(.init($0))
                })
            })
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        return state
    }

}
