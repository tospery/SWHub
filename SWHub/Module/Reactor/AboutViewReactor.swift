//
//  AboutViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/6.
//

import Foundation

class AboutViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Portal: Int {
        case author
        case scheme
        case grade
        case share
    
        static let allValues = [author, scheme, grade, share]
    
        var title: String {
            switch self {
            case .author: return R.string.localizable.author()
            case .scheme: return R.string.localizable.urlSchemes()
            case .grade: return R.string.localizable.scoreToEncourage()
            case .share: return R.string.localizable.shareToFriends()
            }
        }
        
    }
    
    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setTitle(String?)
        case setPortals([Portal])
        case setError(Error?)
    }

    struct State {
        var isLoading = false
        var title: String?
        var portals = [Portal].init()
        var sections = [Section].init()
        var error: Error?
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.about()
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .just(.setPortals(Portal.allValues))
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
            newState.sections = [.sectionItems(
                header: "",
                items: portals.map {
                    Simple.init($0.rawValue, $0.title)
                }.map {
                    SimpleItem.init($0)
                }.map {
                    SectionItem.simple($0)
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
