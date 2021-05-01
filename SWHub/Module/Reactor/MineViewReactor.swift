//
//  MineViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class MineViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var sections = [Section].init()
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.mine()
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            if error != nil && state.isLoading {
                newState.isLoading = false
            }
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
            newState.sections = [Section.sectionItems(header: "", items: [
                .simple(.init(BaseModel.init()))
            ])]
        }
        return newState
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let user = Subjection.for(User.self).asObservable().map(Mutation.setUser)
        return .merge(mutation, user)
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
