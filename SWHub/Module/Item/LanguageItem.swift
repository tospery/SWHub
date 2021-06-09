//
//  LanguageItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import Foundation

class LanguageItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var selected = false
        var name: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let language = model as? Language else { return }
        self.initialState = State(
            name: language.name
        )
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
