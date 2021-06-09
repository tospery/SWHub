//
//  TextFieldCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/27.
//

import UIKit

extension Reactive where Base: TextFieldCell {
    
    var text: ControlProperty<String?> {
        self.base.textField.rx.text
    }

}
