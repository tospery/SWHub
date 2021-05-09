//
//  ProfileViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/9.
//

import Foundation

class ProfileViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setTitle(String?)
        case setPortals([[Portal]])
        case setError(Error?)
    }

    struct State {
        var isLoading = false
        var title: String?
        var portals = [[Portal]].init()
        var sections = [Section].init()
        var error: Error?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.profileTitle()
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .just(.setPortals(Portal.allSections))
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
        case let .setPortals(portals):
            newState.portals = portals
            newState.sections = portals.map { portals -> Section in
                let models: [Simple] = portals.map { Simple.init(
                    id: $0.rawValue,
                    title: $0.title,
                    detail: $0.detail
                )}
                let items: [SimpleItem] = models.map { SimpleItem.init($0) }
                let sectionItems: [SectionItem] = items.map { SectionItem.simple($0) }
                return Section.sectionItems(header: "", items: sectionItems)
            }
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
