//
//  MenuViewReactor+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/20.
//

import Foundation

extension MenuViewReactor {
    
    func load() -> Observable<Mutation> {
        let sinces = Since.allValues.map { BaseModel.init($0) }
        let languages = Language.cachedArray()!
        return .just(.initial([sinces, languages]))
    }
    
    func initial(_ state: State, _ models: [[ModelType]]) -> State {
        var newState = state
        newState.models = models
        newState.sections = [
            .sectionItems(
                header: R.string.localizable.since(),
                items: models[0].map { SectionItem.since(.init($0)) }
            ),
            .sectionItems(
                header: R.string.localizable.language(),
                items: models[1].map { SectionItem.language(.init($0)) }
            )
        ]
        return newState
    }
    
}
