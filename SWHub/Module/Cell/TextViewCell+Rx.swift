//
//  TextViewCell+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/5/28.
//

import UIKit

extension Reactive where Base: TextViewCell {
    
    var text: ControlProperty<String?> {
        self.base.textView.rx.text
    }

}
