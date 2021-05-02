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
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: FeedbackViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.languages }
//            .distinctUntilChanged()
//            .filterEmpty()
//            .subscribeNext(weak: self, type(of: self).handle)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.items }
//            .mapTo(())
//            .bind(to: self.paging.rx.reloadData)
//            .disposed(by: self.disposeBag)
    }
    
}
