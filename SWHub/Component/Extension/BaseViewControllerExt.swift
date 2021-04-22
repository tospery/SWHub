//
//  BaseViewControllerExt.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

extension BaseViewController {

    @objc func myViewDidLoad() {
        self.myViewDidLoad()
        themeService.rx
            .bind({ $0.titleColor }, to: self.navigationBar.rx.itemColor)
            .bind({ $0.lightColor }, to: self.navigationBar.rx.backgroundColor)
            .bind({ $0.borderColor }, to: self.navigationBar.rx.lineColor)
            .bind({ $0.titleColor }, to: self.navigationBar.rx.titleColor)
            .disposed(by: self.rx.disposeBag)
    }

}
