//
//  ReadmeContentItem.swift
//  SWHub
//
//  Created by liaoya on 2021/5/11.
//

import Foundation

class ReadmeContentItem: BaseCollectionItem, ReactorKit.Reactor {

    enum Action {
        case height(CGFloat)
    }

    enum Mutation {
        case setHeight(CGFloat)
    }
    
    struct State {
        var height = 0.f
        var markdown: String?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let readme = model as? Readme else { return }
        self.initialState = State(
            height: readme.height,
            markdown: readme.markdown
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .height(height):
            return .just(.setHeight(height))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setHeight(height):
            newState.height = height
        }
        return newState
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
