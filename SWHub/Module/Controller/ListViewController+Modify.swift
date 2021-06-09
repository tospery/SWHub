//
//  ListViewController+Modify.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import UIKit

extension ListViewController {
    
    @objc func handleUserWhenModify(_ data: Any) {
        guard let user = data as? User else { return }
        MainScheduler.asyncInstance.schedule(()) { [weak self] _ -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            User.update(user, reactive: true)
            let url = Router.urlString(host: .toast).url!
                .appendingQueryParameters([
                    Parameter.message: R.string.localizable.tipsSuccess(R.string.localizable.update())
                ])
            self.navigator.open(url)
            self.navigationController?.popViewController()
            return Disposables.create {}
        }.disposed(by: self.disposeBag)
    }
    
}
