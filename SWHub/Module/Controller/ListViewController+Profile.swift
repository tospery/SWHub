//
//  ListViewController+Profile.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

extension ListViewController {
    
    @objc func tapCellWhenProfile(_ data: Any!) {
        guard let sectionItem = data as? SectionItem else { return }
        switch sectionItem {
        case let .simple(item):
            guard let simple = item.model as? Simple else { return }
            guard let portal = Portal.init(rawValue: simple.id) else { return }
            guard let urlScheme = portal.urlScheme else { return }
            var parameters = [String: String].init()
            parameters[Parameter.portal] = portal.rawValue.string
            parameters[Parameter.value] = item.currentState.detail?.string
            self.navigator.forward(urlScheme.url!.appendingQueryParameters(parameters))
        case .logout:
            (self.navigator as? Navigator)?.rx.open(
                Router.urlString(host: .alert).url!.appendingQueryParameters([
                    Parameter.message: R.string.localizable.tipsLogout()
                ]),
                context: [
                    Parameter.actions: [SimpleAlertAction.cancel, SimpleAlertAction.default]
                ]
            )
            .filter { ($0 as? SimpleAlertAction)?.style == .default }
            .subscribeNext(weak: self, type(of: self).logout)
            .disposed(by: self.disposeBag)
        default:
            break
        }
    }
    
    func logout(any: Any) {
        User.update(nil, reactive: true)
        self.navigationController?.popToRootViewController(animated: false)
    }

}
