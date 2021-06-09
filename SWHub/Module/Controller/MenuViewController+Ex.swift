//
//  MenuViewController+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/20.
//

import UIKit

extension MenuViewController {
    
    func toAction(reactor: MenuViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: MenuViewReactor) {
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
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }

    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
//        switch sectionItem {
//        case let .simple(item):
//            guard let simple = item.model as? Simple else { return }
//            guard let portal = AboutViewReactor.Portal.init(rawValue: simple.id) else { return }
//            switch portal {
//            case .share:
//                UMSocialUIManager.setPreDefinePlatforms([
//                    UMSocialPlatformType.wechatSession.rawValue,
//                    UMSocialPlatformType.wechatTimeLine.rawValue
//                ])
//                UMSocialUIManager.showShareMenuViewInWindow { [weak self] (type, _) in
//                    guard let `self` = self else { return }
//                    self.share(to: type)
//                }
//            default:
//                break
//            }
//        default:
//            break
//        }
    }
    
}
