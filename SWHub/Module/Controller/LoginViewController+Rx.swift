//
//  LoginViewController+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/4/23.
//

import UIKit

extension Reactive where Base: LoginViewController {

    var token: ControlProperty<String?> {
        self.base.tokenTextField.rx.text
    }
    
    var login: ControlEvent<Void> {
        self.base.loginButton.rx.tap
    }
    
}
