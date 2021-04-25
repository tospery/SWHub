//
//  RepoItem.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

class RepoItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var ranking = 0
        var icon: ImageSource?
        var title: String?
        var desc: NSAttributedString?
        var lang: NSAttributedString?
        var star: NSAttributedString?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
    }
    
    init(_ model: ModelType, _ ranking: Int) {
        super.init(model)
        guard let repo = model as? Repo else { return }
        self.initialState = State(
            ranking: ranking,
            icon: repo.avatar?.url,
            title: "\(repo.author ?? "")/\(repo.name ?? "")",
            desc: repo.desc?.styled(with: .font(.systemFont(ofSize: 15)),
                                    .lineHeightMultiple(1.1),
                                    .lineBreakMode(.byTruncatingTail)),
            lang: repo.languageAttrString,
            star: repo.starsAttrString
        )
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
//        switch mutation {
//        case let .setDetail(detail):
//            newState.detail = detail
//        }
//        return newState
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
