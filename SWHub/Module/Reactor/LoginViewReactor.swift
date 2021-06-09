//
//  LoginViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import SafariServices

class LoginViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
        case login
        case oauth
        case token(String?)
    }

    enum Mutation {
        case setActivating(Bool)
        case setCode(String?)
        case setToken(String?)
        case setError(Error?)
        case setUser(User?)
    }

    struct State {
        var isActivating = false
        var error: Error?
        var code: String?
        var token: String?
        var user: User?
    }

    var authSession: SFAuthenticationSession!
    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
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
                .just(.setActivating(true)),
                self.login().map(Mutation.setUser),
                .just(.setActivating(false))
            ]).catchError({
                Observable.concat([
                    .just(.setError($0)),
                    .just(.setActivating(false))
                ])
            })
        case .oauth:
            return Observable.concat([
                .just(.setError(nil)),
                self.oauthCode().map(Mutation.setCode),
                .just(.setActivating(true)),
                self.oauthToken().map(Mutation.setToken),
                self.login().map(Mutation.setUser),
                .just(.setActivating(false))
            ]).catchError({
                Observable.concat([
                    .just(.setError($0)),
                    .just(.setActivating(false))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setActivating(isActivating):
            newState.isActivating = isActivating
        case let .setError(error):
            newState.error = error
        case let .setCode(code):
            newState.code = code
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
        mutation
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

    func login() -> Observable<User> {
        Observable<User>.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            guard let token = self.currentState.token, !token.isEmpty else {
                observer.onError(APPError.loginFailure(nil))
                return Disposables.create { }
            }
            return self.provider.login(token: token)
                .asObservable()
                .flatMap { user -> Observable<User> in
                    var user = user
                    user.token = token
                    return .just(user)
                }.subscribe(observer)
        }
    }
    
    func oauthCode() -> Observable<String> {
        Observable<String>.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            let url = Router.Web.oauth.urlString.url!
            self.authSession = .init(
                url: url,
                callbackURLScheme: UIApplication.shared.urlScheme,
                completionHandler: { callback, error in
                    if let error = error {
                        observer.onError(error)
                        return
                    }
                    guard let code = callback?.queryValue(for: Parameter.code) else {
                        observer.onError(APPError.oauthFailure)
                        return
                    }
                    observer.onNext(code)
                    observer.onCompleted()
                })
            self.authSession.start()
            return Disposables.create { [weak self] in
                guard let `self` = self else { return }
                self.authSession.cancel()
            }
        }
    }
    
    func oauthToken() -> Observable<String> {
        Observable<String>.create { [weak self] observer -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            guard let code = self.currentState.code, !code.isEmpty else {
                observer.onError(APPError.loginFailure(nil))
                return Disposables.create { }
            }
            return self.provider.token(code: code).flatMap({ token in
                guard let token = token.accessToken, !token.isEmpty else {
                    return .error(APPError.oauthFailure)
                }
                return .just(token)
            }).asObservable()
            .subscribe(observer)
        }
    }
    
}
