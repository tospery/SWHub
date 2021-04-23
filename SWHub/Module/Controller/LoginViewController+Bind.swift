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
//        Observable.merge([
//            self.rx.viewDidLoad.map { Reactor.Action.load },
//            self.rx.emptyDataSet.map { Reactor.Action.load }
//        ])
//        .bind(to: reactor.action)
//        .disposed(by: self.disposeBag)
//        self.rx.phone.map { Reactor.Action.phone($0) }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.rx.captcha.map { Reactor.Action.captcha($0) }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.rx.getcode.map { Reactor.Action.getcode }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.rx.login.map { Reactor.Action.login }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: LoginViewReactor) {
//        reactor.state.map { $0.title }
//            .distinctUntilChanged()
//            .bind(to: self.navigationBar.titleLabel.rx.text)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.isLoading }
//            .distinctUntilChanged()
//            .bind(to: self.rx.loading())
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.user }
//            .distinctUntilChanged()
//            .skip(1)
//            .filterNil()
//            .subscribeNext(weak: self, type(of: self).handle)
//            .disposed(by: self.disposeBag)
//        Observable.combineLatest(
//            reactor.state.map { $0.phone }.distinctUntilChanged(),
//            reactor.state.map { $0.captcha }.distinctUntilChanged()
//        )
//        .map { $0?.isNotEmpty ?? false && $1?.isNotEmpty ?? false }
//        .distinctUntilChanged()
//        .bind(to: self.loginButton.rx.isEnabled)
//        .disposed(by: self.disposeBag)
    }
    
}
