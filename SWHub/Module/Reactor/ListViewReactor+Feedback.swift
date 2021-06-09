//
//  ListViewReactor+Feedback.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import Foundation

extension ListViewReactor {
    
    // swiftlint:disable cyclomatic_complexity
    @objc func reduceWhenFeedback(_ param1: Any!, _ param2: Any!) -> Any {
        guard var state = param1 as? State else { fatalError() }
        guard let value = param2 as? Int else { return state }
        guard let type = MutationType.init(rawValue: value) else { return state }
        if type != .user {
            return state
        }
        state.models = Portal.feedbackSections.map {
            $0.map {
                if $0 == .button {
                    return BaseModel.init((key: $0, value: R.string.localizable.submit()))
                }
                return BaseModel.init(((key: $0, value: nil) as KVTuple))
            }
        }
        state.noMoreData = (state.models.count == 0 ? false : state.models[0].count < self.pageSize)
        state.sections = (state.models.count == 0 ? [] : state.models.map {
            .sectionItems(header: "", items: $0.map {
                guard let base = $0 as? BaseModel else { return .empty(.init($0)) }
                guard let portal = (base.data as? KVTuple)?.key as? Portal else { return .empty(.init($0)) }
                switch portal {
                case .feedbackInput: return .feedbackInput(.init($0))
                case .feedbackNote: return .feedbackNote(.init($0))
                case .button: return .button(.init($0))
                default: return .empty(.init($0))
                }
            })
        })
        return state
    }
    // swiftlint:enable cyclomatic_complexity
    
    @objc func activateWhenFeedback(_ data: Any!) -> Any {
        Observable<Issue>.create { observer -> Disposable in
            guard let texts = self.currentState.value as? [String?],
                  texts.count == 2,
                  let title = texts[1],
                  let body = texts[0] else {
                observer.onError(SWFError.unknown)
                return Disposables.create { }
            }
            return self.provider.feedback(title: title, body: body)
                .asObservable()
                .subscribe(observer)
        }.map { issue -> Data in
            var data = self.currentState.data
            data.issue = issue
            return data
        }.map(Mutation.setData)
    }

}
