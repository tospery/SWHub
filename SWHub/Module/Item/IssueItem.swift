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
        var title: String?
        var avatar: ImageSource?
        var username: String?
        var time: String?
        var comments = 0
        var labels = [Label].init()
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let issue = model as? Issue else { return }
//        var labels = [Label].init()
//        var label1 = Label.init()
//        label1.name = "bug"
//        label1.color = "fc2929"
//        labels.append(label1)
//        var label2 = Label.init()
//        label2.name = "infra"
//        label2.color = "75db72"
//        labels.append(label2)
        self.initialState = State(
            icon: issue.state.icon,
            title: issue.title,
            avatar: issue.user?.avatar?.url,
            username: issue.user?.username,
            time: issue.timeAgoSinceNow,
            comments: issue.comments,
            labels: issue.labels
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
