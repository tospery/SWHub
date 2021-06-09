//
//  ListViewReactor+Issue.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/22.
//

import Foundation

extension ListViewReactor {
    
    func initialIssues(_ state: State, _ models: [[ModelType]]) -> State {
        var newState = state
        newState.models = models
        newState.noMoreData = models.count == 0 ? false : models[0].count < self.pageSize
        newState.sections = models.count == 0 ? [] : [
            .sectionItems(
                header: "",
                items: models[0].map { SectionItem.issue(.init($0)) }
            )
        ]
        return newState
    }
    
    func appendIssues(_ state: State, _ models: [[ModelType]]) -> State {
        var newState = state
        newState.models.append(contentsOf: models)
        newState.noMoreData = models.count == 0 ? false : models[0].count < self.pageSize
        var items = newState.sections[0].items
        items += (models.count == 0 ? [] : models[0]).map { .issue(.init($0)) }
        newState.sections = models.count == 0 ? [] : [
            .sectionItems(
                header: "",
                items: items
            )
        ]
        return newState
    }
    
}
