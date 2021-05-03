//
//  FeedbackViewController+Bind.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/2.
//

import UIKit

extension FeedbackViewController {
    
    func bind(reactor: FeedbackViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    func toAction(reactor: FeedbackViewReactor) {
//        Observable.merge([
//            self.rx.viewDidLoad.map { Reactor.Action.load },
//            self.rx.emptyDataSet.map { Reactor.Action.load }
//        ])
//        .bind(to: reactor.action)
//        .disposed(by: self.disposeBag)
        self.rx.feedback.map { Reactor.Action.feedback($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.rx.submit.map { Reactor.Action.submit }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
//        self.mainView.rx.submit.subscribe(onNext: { _ in
//            log("abc")
//        }).disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: FeedbackViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.subject }
            .distinctUntilChanged()
            .bind(to: self.rx.subject)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWError == $1?.asSWError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isFinished }
            .distinctUntilChanged()
            .ignore(false)
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
    }
    
}
