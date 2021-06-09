//
//  SimpleItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class SimpleItem: BaseCollectionItem, ReactorKit.Reactor {

    enum Action {
        case title(String?)
        case detail(NSAttributedString?)
    }
    
    enum Mutation {
        case setTitle(String?)
        case setDetail(NSAttributedString?)
    }
    
    struct State {
        var icon: ImageSource?
        var title: String?
        var detail: NSAttributedString?
        var indicated = true
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let simple = model as? Simple else { return }
        self.initialState = State(
            icon: simple.icon,
            title: simple.title,
            detail: simple.detail,
            indicated: simple.indicated
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .title(title):
            return .just(.setTitle(title))
        case let .detail(detail):
            return .just(.setDetail(detail))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTitle(title):
            newState.title = title
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
