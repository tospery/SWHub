//
//  ThemeViewReactor.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import Foundation

class ThemeViewReactor: TableViewReactor, ReactorKit.Reactor {
    
    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setTitle(String?)
        case setColorThemes([ColorTheme])
        case setError(Error?)
    }

    struct State {
        var isLoading = false
        var title: String?
        var colorThemes = [ColorTheme].init()
        var sections = [Section].init()
        var error: Error?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.minePortalTheme()
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .just(.setColorThemes(ColorTheme.allValues))
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
        case let .setColorThemes(colorThemes):
            newState.colorThemes = colorThemes
            newState.sections = [.sectionItems(
                header: "",
                items: colorThemes.map {
                    BaseModel.init($0)
                }.map {
                    ThemeItem.init($0)
                }.map {
                    SectionItem.theme($0)
                }
            )]
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
