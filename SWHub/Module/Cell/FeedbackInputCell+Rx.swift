//
//  FeedbackInputCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import UIKit

extension Reactive where Base: FeedbackInputCell {
    
    var title: Binder<String?> {
        self.base.label.rx.text
    }

    var body: ControlProperty<String?> {
        self.base.textView.rx.text
    }
    
}
