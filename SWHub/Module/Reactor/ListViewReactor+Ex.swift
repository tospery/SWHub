//
//  ListViewReactor+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/21.
//

import Foundation

extension ListViewReactor {
    
    // MARK: - actions
    func load() -> Observable<Mutation> {
        var load: Observable<Mutation>?
        let selector = Selector.init(
            "load/when/\(self.host.rawValue)/\(self.path?.rawValue ?? "")".method
        )
        if self.responds(to: selector) {
            load = self.perform(selector).takeUnretainedValue() as? Observable<Mutation>
        } else {
            log("缺少\(selector)，采用默认的loadModels", module: .runtime)
        }
        guard !self.currentState.isLoading else { return .empty() }
        return Observable.concat([
            .just(.setError(nil)),
            .just(.setLoading(true)),
//            Observable<Mutation>.create { [weak self] observer -> Disposable in
//                guard let `self` = self else { return Disposables.create { } }
//                let myLoad = load ?? self.loadModels(self.pageStart).errorOnEmpty().map(Mutation.initial)
//                myLoad.subscribe(observer).disposed(by: self.disposeBag)
//                return Disposables.create { }
//            },
            load ??
                self.loadModels(self.pageStart)
                .errorOnEmpty()
                .map(Mutation.initial),
            .just(.setLoading(false))
        ]).do(onCompleted: { [weak self] in
            guard let `self` = self else { return }
            self.pageIndex = self.pageStart
        }).catchError({
            Observable.concat([
                .just(.initial([])),
                .just(.setError($0)),
                .just(.setLoading(false))
            ])
        })
    }
    
    func refresh() -> Observable<Mutation> {
        var refresh: Observable<Mutation>?
        let selector = Selector.init(
            "refresh/when/\(self.host.rawValue)/\(self.path?.rawValue ?? "")".method
        )
        if self.responds(to: selector) {
            refresh = self.perform(selector).takeUnretainedValue() as? Observable<Mutation>
        } else {
            log("缺少\(selector)，采用默认的loadModels", module: .runtime)
        }
        guard !self.currentState.isRefreshing else { return .empty() }
        return Observable.concat([
            .just(.setError(nil)),
            .just(.setRefreshing(true)),
            refresh ??
                self.loadModels(self.pageStart)
                .errorOnEmpty()
                .map(Mutation.initial),
            .just(.setRefreshing(false))
        ]).do(onCompleted: { [weak self] in
            guard let `self` = self else { return }
            self.pageIndex = self.pageStart
        }).catchError({
            Observable.concat([
                .just(.setError($0)),
                .just(.setRefreshing(false))
            ])
        })
    }
    
    func loadMore() -> Observable<Mutation> {
        var loadMore: Observable<Mutation>?
        let selector = Selector.init(
            "load/more/when/\(self.host.rawValue)/\(self.path?.rawValue ?? "")".method
        )
        if self.responds(to: selector) {
            loadMore = self.perform(selector).takeUnretainedValue() as? Observable<Mutation>
        } else {
            log("缺少\(selector)，采用默认的loadModels", module: .runtime)
        }
        guard !self.currentState.isLoadingMore else { return .empty() }
        return Observable.concat([
            .just(.setError(nil)),
            .just(.setLoadingMore(true)),
            loadMore ??
                self.loadModels(self.pageIndex + 1)
                .errorOnEmpty()
                .map(Mutation.append),
            .just(.setLoadingMore(false))
        ]).do(onCompleted: { [weak self] in
            guard let `self` = self else { return }
            self.pageIndex += 1
        }).catchError({
            Observable.concat([
                .just(.setError($0)),
                .just(.setLoadingMore(false))
            ])
        })
    }
    
    func activate(_ data: Any?) -> Observable<Mutation> {
        var activate: Observable<Mutation>!
        let selector = Selector.init(
            "activate/when/\(self.host.rawValue)/\(self.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            activate = self.perform(selector, with: data).takeUnretainedValue() as? Observable<Mutation> ?? .empty()
        } else {
            log("缺少\(selector)", module: .runtime)
            return Observable.concat([
                .just(.setActive(nil)),
                .just(.setActive(data))
            ])
        }
        guard !self.currentState.isActivating else { return .empty() }
        return Observable.concat([
            .just(.setError(nil)),
            .just(.setActivating(true)),
            activate,
            .just(.setActivating(false))
        ]).catchError({
            Observable.concat([
                .just(.setError($0)),
                .just(.setActivating(false))
            ])
        })
    }
    
    func reduce(_ state: State, _ mutationType: MutationType) -> State {
        let selector = Selector.init(
            "reduce/when/\(self.host.rawValue)/\(self.path?.rawValue ?? "")::".method
        )
        if self.responds(to: selector) {
            return self.perform(
                selector, with: state, with: mutationType.rawValue
            ).takeUnretainedValue() as? State ?? state
        }
        log("缺少\(selector)", module: .runtime)
        return state
    }
    
    // MARK: - models
    func loadModels(_ page: Int) -> Observable<[[ModelType]]> {
        let selector = Selector.init(
            "load/models/when/\(self.host.rawValue)/\(self.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            return self.perform(selector, with: page).takeUnretainedValue() as? Observable<[[ModelType]]> ?? .empty()
        }
        log("缺少\(selector), 不进行数据加载", module: .runtime)
        return .empty()
    }
    
    // MARK: - request
    func userinfo() -> Observable<User> {
        Observable<User>.create { observer -> Disposable in
            guard let username = self.currentState.user?.username,
                  let token = self.currentState.user?.token,
                  !username.isEmpty, !token.isEmpty else {
                observer.onError(SWFError.unknown)
                return Disposables.create { }
            }
            return self.provider.user(username: username)
                .asObservable()
                .map { user -> User in
                    var user = user
                    user.token = token
                    return user
                }.subscribe(observer)
        }
    }
    
}
