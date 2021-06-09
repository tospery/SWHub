//
//  SinceItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/20.
//

import Foundation

class SinceItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var selected = false
        var name: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let since = (model as? BaseModel)?.data as? Since else { return }
        self.initialState = State(
            name: since.rawValue
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
