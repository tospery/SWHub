//
//  ListViewController+Scheme.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/24.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenScheme(_ data: Any) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .scheme(item):
            guard let model = item.model as? BaseModel else { return }
            guard let tuple = model.data as? KVTuple else { return }
            let pasteboard = UIPasteboard.general
            pasteboard.string = tuple.value as? String
            let url = Router.urlString(host: .toast).url!
                .appendingQueryParameters([
                    Parameter.message: R.string.localizable.tipsCopy()
                ])
            self.navigator.open(url)
        default:
            break
        }
    }
    
}
