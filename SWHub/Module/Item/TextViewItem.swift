//
//  TextViewItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/28.
//

import Foundation

class TextViewItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var text: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let tuple = (model as? BaseModel)?.data as? KVTuple else { return }
        self.initialState = State(
            text: tuple.value as? String
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
