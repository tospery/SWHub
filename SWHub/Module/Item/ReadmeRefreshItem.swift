//
//  ReadmeRefreshItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/17.
//

import Foundation

class ReadmeRefreshItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: String?
        var icon: ImageSource?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        self.initialState = State(
            title: R.string.localizable.readme(),
            icon: R.image.repo_readme()?.template
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
