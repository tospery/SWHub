//
//  FeedbackNoteCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import UIKit

extension Reactive where Base: FeedbackNoteCell {
    
    var issues: ControlEvent<Void> {
        let source = self.base.issuesSubject.map { _ in }
        return ControlEvent(events: source)
    }
    
}
