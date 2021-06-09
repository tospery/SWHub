//
//  RepoItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import Foundation

class RepoItem: BaseCollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var ranking: Int?
        var reponame: String?
        var status: String?
        var stars: NSAttributedString?
        var language: NSAttributedString?
        var desc: NSAttributedString?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let repo = model as? Repo else { return }
        self.initialState = State(
            ranking: repo.ranking != nil ? repo.ranking! + 1 : nil,
            reponame: repo.fullname,
            status: repo.statusText,
            stars: repo.starsStyle1,
            language: repo.languageStyle,
            desc: repo.descStyle
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
