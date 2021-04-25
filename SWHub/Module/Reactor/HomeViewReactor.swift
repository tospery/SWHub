//
//  HomeViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class HomeViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
        case setRepos([Repo])
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var repos = [Repo].init()
        var sections = [Section].init()
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.home()
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setLoading(true)),
                self.provider.repositories(language: nil, since: nil)
                    .asObservable()
                    .map(Mutation.setRepos),
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
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
        case let .setRepos(repos):
            newState.repos = repos
            let items = repos.enumerated().map { RepoItem.init($0.element, $0.offset) }
            let sectionItems = items.map { SectionItem.repo($0) }
            newState.sections = [.sectionItems(header: "", items: sectionItems)]
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

}
