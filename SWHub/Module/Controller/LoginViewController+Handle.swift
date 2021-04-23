//
//  LoginViewController+Handle.swift
//  SWHub
//
//  Created by liaoya on 2021/4/23.
//

import UIKit

extension LoginViewController {
    
    func handle(user: User) {
        User.update(user)
    }
    
}
