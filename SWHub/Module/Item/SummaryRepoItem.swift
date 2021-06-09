//
//  SummaryRepoItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/31.
//

import Foundation

class SummaryRepoItem: BaseCollectionItem, ReactorKit.Reactor {

    enum Action {
        case time(String?)
        case desc(NSAttributedString?)
        case name(String?)
        case watches(NSAttributedString?)
        case stars(NSAttributedString?)
        case forks(NSAttributedString?)
    }
        
    enum Mutation {
        case setTime(String?)
        case setDesc(NSAttributedString?)
        case setName(String?)
        case setWatches(NSAttributedString?)
        case setStars(NSAttributedString?)
        case setForks(NSAttributedString?)
    }

    struct State {
        var time: String?
        var desc: NSAttributedString?
        var name: String?
        var watches: NSAttributedString?
        var stars: NSAttributedString?
        var forks: NSAttributedString?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .desc(desc):
            return .just(.setDesc(desc))
        case let .time(time):
            return .just(.setTime(time))
        case let .name(name):
            return .just(.setName(name))
        case let .watches(watches):
            return .just(.setWatches(watches))
        case let .stars(stars):
            return .just(.setStars(stars))
        case let .forks(forks):
            return .just(.setForks(forks))
        }
    }
            
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setDesc(desc):
            newState.desc = desc
        case let .setTime(time):
            newState.time = time
        case let .setName(name):
            newState.name = name
        case let .setWatches(watches):
            newState.watches = watches
        case let .setStars(stars):
            newState.stars = stars
        case let .setForks(forks):
            newState.forks = forks
        }
        return newState
    }
    
    func transform(action: Observable<NoAction>) -> Observable<NoAction> {
        action
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation
    }

    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
