//
//  IssueListViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import Foundation

class IssueListViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
        case refresh
        case state(SWHub.State)
    }

    enum Mutation {
        case setEmptying(Bool)
        case setLoading(Bool)
        case setRefreshing(Bool)
        case setTitle(String?)
        case setState(SWHub.State)
        case setError(Error?)
        case setIssues([Issue])
    }

    struct State {
        var isEmptying = false
        var isLoading = false
        var isRefreshing = false
        var title: String?
        var error: Error?
        var state = SWHub.State.all
        var issues = [Issue].init()
        var sections = [Section].init()
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.issues()
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .state(state):
            return .just(.setState(state))
        case .load:
            return Observable.concat([
                .just(.setEmptying(true)),
                .just(.setError(nil)),
                .just(.setLoading(true)),
                self.issues(self.currentState.state, self.pageIndex),
                .just(.setLoading(false)),
                .just(.setEmptying(false))
            ]).catchError({
                Observable.concat([
                    .just(.setLoading(false)),
                    .just(.setError($0)),
                    .just(.setEmptying(false))
                ])
            })
        case .refresh:
            return Observable.concat([
                .just(.setEmptying(true)),
                .just(.setError(nil)),
                .just(.setRefreshing(true)),
                self.issues(self.currentState.state, self.pageIndex),
                .just(.setRefreshing(false)),
                .just(.setEmptying(false))
            ]).catchError({
                Observable.concat([
                    .just(.setRefreshing(false)),
                    .just(.setError($0)),
                    .just(.setEmptying(false))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setEmptying(isEmptying):
            newState.isEmptying = isEmptying
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        case let .setState(state):
            newState.state = state
        case let .setError(error):
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setIssues(issues):
            newState.issues = issues
            newState.sections = [.sectionItems(
                header: "",
                items: issues.map {
                    IssueItem.init($0)
                }.map {
                    SectionItem.issue($0)
                }
            )]
        }
        return newState
    }
    
    func issues(_ state: SWHub.State, _ page: Int) -> Observable<Mutation> {
        self.provider.issues(state: state, page: page).asObservable().map(Mutation.setIssues)
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
