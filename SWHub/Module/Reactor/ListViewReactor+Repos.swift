//
//  ListViewReactor+Repos.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/30.
//

import Foundation

extension ListViewReactor {
    
    @objc func loadModelsWhenReposTrending(_ param: Any!) -> Any {
        return Observable<[[ModelType]]>.create { observer -> Disposable in
            self.provider.repositories(
                language: self.currentState.language,
                since: self.currentState.since
            ).asObservable()
            .map { repos -> [[ModelType]] in
                return [repos.enumerated().map { iterator -> Repo in
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
    
    @objc func loadModelsWhenReposStars(_ param: Any!) -> Any {
        guard let page = param as? Int else { return Observable<[[ModelType]]>.empty() }
        return Observable<[[ModelType]]>.create { observer -> Disposable in
            guard let username = self.username, !username.isEmpty else {
                observer.onError(SWFError.unknown)
                return Disposables.create { }
            }
            self.provider.starredRepos(
                username: username, page: page
            ).asObservable()
            .map { [$0] }
            .subscribe(observer)
            .disposed(by: self.disposeBag)
            return Disposables.create { }
        }
    }
    
    @objc func loadModelsWhenReposSearch(_ param: Any!) -> Any {
        guard let page = param as? Int else { return Observable<[[ModelType]]>.empty() }
        return Observable<[[ModelType]]>.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create { } }
            self.provider.searchRepos(
                keyword: self.keyword, sort: self.sort, order: self.order, page: page
            ).asObservable()
            .map { [$0] }
            .subscribe(observer).disposed(by: self.disposeBag)
            return Disposables.create { }
        }
    }
    
    @objc func reduceWhenReposTrending(_ param1: Any!, _ param2: Any!) -> Any {
        guard let state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        return self.reduceWhenRepos(state, type)
    }
    
    @objc func reduceWhenReposStars(_ param1: Any!, _ param2: Any!) -> Any {
        guard let state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        return self.reduceWhenRepos(state, type)
    }
    
    @objc func reduceWhenReposSearch(_ param1: Any!, _ param2: Any!) -> Any {
        guard let state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        return self.reduceWhenRepos(state, type)
    }
    
    func reduceWhenRepos(_ state: State, _ mutationType: MutationType) -> State {
        var state = state
        if mutationType == .append {
            var models = state.models[0]
            models.append(contentsOf: state.additions[0])
            state.models = [models]
            var items = state.sections[0].items
            items.append(contentsOf: state.additions[0].map {
                .repo(.init($0))
            })
            state.sections = [
                .sectionItems(header: "", items: items)
            ]
        } else {
            state.sections = (state.models.count == 0 ? [] : state.models.map {
                .sectionItems(header: "", items: $0.map {
                    .repo(.init($0))
                })
            })
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        return state
    }

}
