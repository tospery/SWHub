//
//  UserItem.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import Foundation

class UserItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var ranking = 0
        var avatar: ImageSource?
        var username: String?
        var reponame: NSAttributedString?
        var repodesc: NSAttributedString?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
    }
    
    init(_ model: ModelType, _ ranking: Int) {
        super.init(model)
        guard let user = model as? User else { return }
        self.initialState = State(
            ranking: ranking,
            avatar: user.avatar?.url
        )
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        state
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
