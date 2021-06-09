//
//  ListViewReactor+Center.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import Foundation

extension ListViewReactor {
    
    @objc func reduceWhenCenter(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        let isLogined = state.user?.isValid ?? false
        let portals = Portal.centerSections.filter {
            return $0.filter {
                if isLogined {
                    return true
                }
                switch $0 {
                case .company, .location, .email, .blog:
                    return false
                default:
                    return true
                }
            }.count != 0
        }
        state.models = portals.map {
            $0.map {
                switch $0 {
                case .summaryUser:
                    return BaseModel.init((key: $0, value: true))
                case .company, .location, .email, .blog:
                    return Simple.init(
                        id: $0.rawValue, icon: $0.image?.template, indicated: false, identifier: .userDetail
                    )
                default:
                    return Simple.init(id: $0.rawValue, icon: $0.image?.template, title: $0.title)
                }
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                ($0 is BaseModel) ? .summaryUser(.init($0)) : .simple(.init($0))
            })
        })
        return state
    }
    
    @objc func refreshWhenCenter() -> Any {
        self.userinfo().map(Mutation.setUser)
    }
    
}
