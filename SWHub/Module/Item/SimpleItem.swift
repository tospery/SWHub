//
//  SimpleItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class SimpleItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction

    enum Mutation {
        case setDetail(NSAttributedString?)
    }

    struct State {
        var title: String?
        var detail: NSAttributedString?
        var icon: ImageSource?
        var indicated = true
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let simple = model as? Simple else { return }
        self.initialState = State(
            title: simple.title,
            detail: simple.detail,
            icon: simple.icon,
            indicated: simple.indicated
        )
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setDetail(detail):
            newState.detail = detail
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
