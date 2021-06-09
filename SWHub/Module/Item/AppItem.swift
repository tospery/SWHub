//
//  AppItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import Foundation

class AppItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
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
