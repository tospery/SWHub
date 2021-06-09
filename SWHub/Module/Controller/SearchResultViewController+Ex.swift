//
//  SearchResultViewController+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/5.
//

import UIKit

extension SearchResultViewController {
    
    func toAction(reactor: SearchResultViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: SearchResultViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.pages }
            .distinctUntilChanged()
            .mapTo(())
            .bind(to: self.paging.rx.reloadData)
            .disposed(by: self.disposeBag)
    }
    
}
