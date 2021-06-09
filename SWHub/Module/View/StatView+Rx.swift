//
//  StatView+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/5/31.
//

import UIKit

extension Reactive where Base: StatView {
    
    var leftAttributedText: Binder<NSAttributedString?> {
        self.base.leftButton.rx.attributedTitle(for: .normal)
    }
    
    var centerAttributedText: Binder<NSAttributedString?> {
        self.base.centerButton.rx.attributedTitle(for: .normal)
    }
    
    var rightAttributedText: Binder<NSAttributedString?> {
        self.base.rightButton.rx.attributedTitle(for: .normal)
    }

}
