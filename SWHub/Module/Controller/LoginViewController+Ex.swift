//
//  LoginViewController+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/4/23.
//

import UIKit

extension LoginViewController {
    
    func toAction(reactor: LoginViewReactor) {
        self.rx.token
            .distinctUntilChanged()
            .map { Reactor.Action.token($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.rx.login.map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.rx.oauth.map { Reactor.Action.oauth }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: LoginViewReactor) {
        reactor.state.map { $0.isActivating }
            .distinctUntilChanged()
            .bind(to: self.rx.activating)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWFError == $1?.asSWFError })
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
            .filter { _ in !reactor.currentState.isActivating }
            .bind(to: self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    func handle(user: User) {
        User.update(user, reactive: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//    func oauth(event: ControlEvent<Void>.Element) {
//        let url = Router.Web.oauth.urlString.url!
//        self.authSession = .init(
//            url: url,
//            callbackURLScheme: UIApplication.shared.urlScheme,
//            completionHandler: { callback, error in
//                if let error = error {
//                    self.reactor?.action.onNext(.error(error))
//                    return
//                }
//                guard let code = callback?.queryValue(for: Parameter.code) else {
//                    self.reactor?.action.onNext(.error(APPError.oauth))
//                    return
//                }
//                self.reactor?.action.onNext(.oauth(code))
//            })
//        self.authSession.start()
//    }

}
