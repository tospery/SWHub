//
//  LoginViewController+Bind.swift
//  SWHub
//
//  Created by liaoya on 2021/4/23.
//

import UIKit

extension LoginViewController {
    
    func bind(reactor: LoginViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    func toAction(reactor: LoginViewReactor) {
        self.rx.token.map { Reactor.Action.token($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.rx.login.map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: LoginViewReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWError == $1?.asSWError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.user }
            .distinctUntilChanged()
            .skip(1)
            .filterNil()
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.token }
            .distinctUntilChanged()
            .map { $0?.isNotEmpty ?? false }
            .distinctUntilChanged()
            .bind(to: self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
}
