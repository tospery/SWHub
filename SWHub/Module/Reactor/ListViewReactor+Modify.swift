//
//  ListViewReactor+Modify.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import Foundation

extension ListViewReactor {
    
    @objc func reduceWhenModify(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        state.models = Portal.modifySections(with: self.portal).map {
            $0.map {
                if $0 == .button {
                    return BaseModel.init((key: $0, value: R.string.localizable.update()))
                }
                return BaseModel.init((key: $0, value: state.value))
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                guard let base = $0 as? BaseModel else { return .empty(.init($0)) }
                guard let portal = (base.data as? KVTuple)?.key as? Portal else { return .empty(.init($0)) }
                switch portal {
                case .textField: return .textField(.init($0))
                case .textView: return .textView(.init($0))
                case .button: return .button(.init($0))
                default: return .empty(.init($0))
                }
            })
        })
        return state
    }
    
    @objc func activateWhenModify(_ param: Any!) -> Any {
        Observable<User>.create { observer -> Disposable in
            guard let value = self.currentState.value as? String, !value.isEmpty,
                  let key = self.portal.paramName, !key.isEmpty,
                  let token = self.currentState.user?.token else {
                observer.onError(SWFError.unknown)
                return Disposables.create { }
            }
            return self.provider.modify(key: key, value: value)
                .asObservable()
                .map { user -> User in
                    var user = user
                    user.token = token
                    return user
                }.subscribe(observer)
        }.map(Mutation.setUser)
    }

}
