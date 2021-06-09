//
//  SearchHistoryItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import Foundation

class SearchHistoryItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var words = [String].init()
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let history = model as? SearchHistory else { return }
        self.initialState = State(
            words: history.words
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
