//
//  LoginViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class LoginViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
        case token(String?)
        case login
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setToken(String?)
        case setUser(User?)
    }

    struct State {
        var isLoading = false
        var error: Error?
        var token: String?
        var user: User?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
//        self.initialState = State(
//            title: self.title ?? R.string.localizable.login()
//        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .token(token):
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setToken(token))
            ])
        case .login:
            guard let token = self.currentState.token, !token.isEmpty else { return .empty() }
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setLoading(true)),
                self.login(token).map(Mutation.setUser),
                .just(.setLoading(false))
            ]).catchError({
                Observable.concat([
                    .just(.setLoading(false)),
                    .just(.setError($0))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            newState.error = error
        case let .setToken(token):
            newState.token = token
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
        self.provider.login(token: token).asObservable().flatMap { user -> Observable<User> in
            var user = user
            user.token = token
            return .just(user)
        }
    }
    
}
