//
//  FeedbackInputItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import Foundation

class FeedbackInputItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: String?
        //var body: String?
    }

    var initialState = State()
    
    required public init(_ model: ModelType) {
        super.init(model)
        self.initialState = State(
            title: R.string.localizable.feedbackEnvironment(
                UIDevice.current.modelName,
                UIDevice.current.systemVersion,
                UIApplication.shared.version!,
                UIApplication.shared.buildNumber!
            )
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
