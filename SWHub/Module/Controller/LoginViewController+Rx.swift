//
//  LoginViewController+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/5/26.
//

import UIKit

extension Reactive where Base: LoginViewController {

    var token: ControlProperty<String?> {
        self.base.tokenTextField.rx.text
    }
    
    var login: ControlEvent<Void> {
        self.base.loginButton.rx.tap
    }
    
    var oauth: ControlEvent<Void> {
        self.base.oauthButton.rx.tap
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
            guard viewController.isViewLoaded else {
                return
            }
            viewController.errorLabel.text = error?.asSWFError.localizedDescription
        }
    }
    
}
