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
        var color: UIColor?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
//        guard let issue = model as? Issue else { return }
//        self.initialState = State(
//            icon: issue.stateIcon,
//            avatar: issue.user?.avatarUrl?.url,
//            username: issue.user?.login,
//            time: issue.timeAgoSinceNow,
//            comments: R.string.localizable.replies((issue.comments ?? 0).string),
//            title: issue.title
//        )
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

