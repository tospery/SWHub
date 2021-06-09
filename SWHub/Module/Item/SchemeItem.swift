//
//  SchemeItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/24.
//

import Foundation

class SchemeItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: String?
        var subtitle: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let tuple = (model as? BaseModel)?.data as? KVTuple else { return }
        self.initialState = State(
            title: tuple.key as? String,
            subtitle: tuple.value as? String
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
