//
//  IssueItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import Foundation

class IssueItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var icon: ImageSource?
        var avatar: ImageSource?
        var username: String?
        var time: String?
        var comments: String?
        var title: String?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let issue = model as? Issue else { return }
        self.initialState = State(
            icon: issue.stateIcon,
            avatar: issue.user?.avatarUrl?.url,
            username: issue.user?.login,
            time: issue.timeAgoSinceNow,
            comments: R.string.localizable.replies((issue.comments ?? 0).string),
            title: issue.title
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
