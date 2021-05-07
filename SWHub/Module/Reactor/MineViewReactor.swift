//
//  MineViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class MineViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Portal: Int {
        case acknowlist
        case feedback
        case about
        
        static let allValues = [acknowlist, feedback, about]
        
        var title: String {
            switch self {
            case .acknowlist: return R.string.localizable.minePortalAcknowlist()
            case .feedback: return R.string.localizable.feedback()
            case .about: return R.string.localizable.about()
            }
        }
        
        var image: UIImage {
            switch self {
            case .acknowlist: return R.image.acknowlist()!
            case .feedback: return R.image.feedback()!
            case .about: return R.image.about()!
            }
        }
        
    }
    
    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
        case setSimples([Simple])
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var simples = [Simple].init()
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
            let simples = Portal.allValues.map { Simple.init($0.rawValue, $0.title, $0.image) }
            return .just(Mutation.setSimples(simples))
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
        case let .setSimples(simples):
            newState.simples = simples
            newState.sections = [.sectionItems(
                header: "",
                items: simples.map {
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
        let user = Subjection.for(User.self).asObservable().map(Mutation.setUser)
        return .merge(mutation, user)
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
