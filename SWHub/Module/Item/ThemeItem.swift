//
//  ThemeItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import Foundation

class ThemeItem: BaseTableItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var checked = false
        var name: String?
        var color: UIColor?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let tuple = (model as? BaseModel)?.data as? KVTuple else { return }
        self.initialState = State(
            checked: tuple.value as? Bool ?? false,
            name: (tuple.key as? ColorTheme)?.title,
            color: (tuple.key as? ColorTheme)?.color
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
