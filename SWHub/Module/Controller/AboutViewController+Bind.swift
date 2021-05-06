//
//  AboutViewController+Bind.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/6.
//

import UIKit

extension AboutViewController {
    
    func bind(reactor: AboutViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    func toAction(reactor: AboutViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: AboutViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWError == $1?.asSWError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }

}
