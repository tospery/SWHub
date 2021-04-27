//
//  HomeViewController+Bind.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

extension HomeViewController {
    
    func bind(reactor: HomeViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    func toAction(reactor: HomeViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: HomeViewReactor) {
        reactor.state.map { $0.items }
            .mapTo(())
            .bind(to: self.paging.rx.reloadData)
            .disposed(by: self.disposeBag)
    }
    
}

