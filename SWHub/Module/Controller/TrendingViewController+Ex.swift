//
//  TrendingViewController+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

extension TrendingViewController {
    
    func toAction(reactor: TrendingViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: TrendingViewReactor) {
        reactor.state.map { $0.languages }
            .distinctUntilChanged()
            .filterEmpty()
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.pages }
            .distinctUntilChanged()
            .mapTo(())
            .bind(to: self.paging.rx.reloadData)
            .disposed(by: self.disposeBag)
    }
    
}
