//
//  TrendingUsersViewReactor.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import Foundation

class TrendingUsersViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
        case refresh
    }

    enum Mutation {
        case setEmptying(Bool)
        case setLoading(Bool)
        case setRefreshing(Bool)
        case setTitle(String?)
        case setUsers([User])
        case setError(Error?)
    }

    struct State {
        var isEmptying = false
        var isLoading = false
        var isRefreshing = false
        var title: String?
        var users = [User].init()
        var sections = [Section].init()
        var error: Error?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.developer()
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load, .refresh:
            var start: Observable<Mutation> = .just(.setLoading(true))
            var end: Observable<Mutation> = .just(.setLoading(false))
            if action == .load {
                guard !self.currentState.isLoading else { return .empty() }
            } else {
                guard !self.currentState.isRefreshing else { return .empty() }
                start = .just(.setRefreshing(true))
                end = .just(.setRefreshing(false))
            }
            return Observable.concat([
                .just(.setEmptying(true)),
                .just(.setError(nil)),
                start,
                self.provider.developers(language: nil, since: nil)
                    .asObservable()
                    .map(Mutation.setUsers),
                end,
                .just(.setEmptying(false))
            ]).catchError({
                Observable.concat([
                    end,
                    .just(.setError($0)),
                    .just(.setEmptying(false))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        case let .setEmptying(isEmptying):
            newState.isEmptying = isEmptying
        case let .setError(error):
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUsers(users):
            newState.users = users
            let items = users.enumerated().map { UserItem.init($0.element, $0.offset) }
            let sectionItems = items.map { SectionItem.user($0) }
            newState.sections = [.sectionItems(header: "", items: sectionItems)]
        }
        return newState
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
