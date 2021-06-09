//
//  TrendingViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class TrendingViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setLanguages([Language])
        case setError(Error?)
    }

    struct State {
        var isLoading = false
        var title: String?
        var languages = [Language].init()
        var pages = PageKey.allValues
        var error: Error?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.trending()
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .empty()
//            guard !self.currentState.isLoading else { return .empty() }
//            return Observable.concat([
//                .just(.setEmptying(true)),
//                .just(.setError(nil)),
//                .just(.setLoading(true)),
//                self.provider.languages().asObservable().map(Mutation.setLanguages),
//                .just(.setLoading(false)),
//                .just(.setEmptying(false))
//            ]).catchError({
//                Observable.concat([
//                    .just(.setLoading(false)),
//                    .just(.setError($0)),
//                    .just(.setEmptying(false))
//                ])
//            })
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setLanguages(languages):
            newState.languages = languages
        case let .setError(error):
            newState.error = error
        }
        return state
    }

}
