//
//  FeedbackViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/2.
//

import Foundation

class FeedbackViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setTitle(String?)
        case setError(Error?)
        case setUser(User?)
    }

    struct State {
        var isLoading = false
        var title: String?
        var error: Error?
        var user: User?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.feedback()
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
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
        }
        return newState
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        let user = Subjection.for(User.self).asObservable().map(Mutation.setUser)
//        return .merge(mutation, user)
        mutation
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

    func login(_ token: String) -> Observable<User> {
        self.provider.login(token: token).asObservable()
    }
    
}
