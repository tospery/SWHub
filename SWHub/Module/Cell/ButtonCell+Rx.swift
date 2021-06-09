//
//  ButtonCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/27.
//

import UIKit

extension Reactive where Base: ButtonCell {
    
    var tap: ControlEvent<Void> {
        self.base.button.rx.tap
    }

}
