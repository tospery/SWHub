//
//  TrendingUserItem.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import Foundation

class TrendingUserItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var ranking = 0
        var avatar: ImageSource?
        var username: NSAttributedString?
        var reponame: NSAttributedString?
        var repodesc: NSAttributedString?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let user = model as? User else { return }
        self.initialState = State(
            ranking: user.ranking,
            avatar: user.avatar?.url,
            username: user.nameStyle,
            reponame: user.reponameStyle,
            repodesc: user.repodescStyle
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
