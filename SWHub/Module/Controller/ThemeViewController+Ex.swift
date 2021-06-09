//
//  ThemeViewController+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import UIKit

extension ThemeViewController {
    
    func toAction(reactor: ThemeViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: ThemeViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWFError == $1?.asSWFError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.sections }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }

    func tapCell(indexPath: ControlEvent<IndexPath>.Element) {
        switch self.dataSource[indexPath] {
        case let .theme(item):
            guard let color = (
                ((item.model as? BaseModel)?.data as? KVTuple)?.key as? ColorTheme
            )?.color else { return }
            themeService.type.toggle(color)
            self.reactor?.action.onNext(.load)
        default:
            break
        }
    }
    
}
