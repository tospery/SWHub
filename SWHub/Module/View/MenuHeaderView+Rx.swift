//
//  MenuHeaderView+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import Foundation

extension Reactive where Base: MenuHeaderView {

    var title: Binder<String?> {
        self.base.label.rx.text
    }

}
