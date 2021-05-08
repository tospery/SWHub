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
        var name: String?
        var color: UIColor?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let colorTheme = (model as? BaseModel)?.value as? ColorTheme else { return }
        self.initialState = State(
            name: colorTheme.title,
            color: UIColor.random
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

