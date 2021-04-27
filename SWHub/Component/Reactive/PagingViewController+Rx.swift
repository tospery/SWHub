//
//  PagingViewController+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import Foundation
import Parchment

extension Reactive where Base: PagingViewController {

    var reloadData: Binder<Void> {
        return Binder(self.base) { paging, _ in
            paging.reloadData()
        }
    }

    var indicatorColor: Binder<UIColor> {
        return Binder(self.base) { paging, color in
            paging.indicatorColor = color
        }
    }

    var textColor: Binder<UIColor> {
        return Binder(self.base) { paging, color in
            paging.textColor = color
        }
    }

    var selectedTextColor: Binder<UIColor> {
        return Binder(self.base) { paging, color in
            paging.selectedTextColor = color
        }
    }

}
