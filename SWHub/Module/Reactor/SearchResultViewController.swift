//
//  SearchResultViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/5.
//

import UIKit
import Parchment
import SnapKit

class SearchResultViewController: ScrollViewController, ReactorKit.View {
    
    lazy var paging: PagingViewController = {
        let paging = PagingViewController.init()
        paging.menuBackgroundColor = .clear
        paging.menuHorizontalAlignment = .center
        paging.borderOptions = .hidden
        paging.menuItemSize = .fixed(width: (UIScreen.width / 2).floorInPixel, height: 40)
        return paging
    }()

    init(_ navigator: NavigatorType, _ reactor: SearchResultViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(self.paging)
        self.view.addSubview(self.paging.view)
        self.paging.view.snp.makeConstraints { [weak self] maker in
            guard let `self` = self else { return }
            maker.edges.equalTo(self.scrollView)
        }
        self.paging.didMove(toParent: self)
        self.paging.dataSource = self

//        self.paging.collectionView.size = CGSize(width: self.view.width, height: UINavigationBar.height)
//        self.navigationBar.titleView = self.paging.collectionView
//
//        self.navigationBar.addButtonToLeft(image: R.image.nav_menu()).rx.tap
//            .subscribeNext(weak: self, type(of: self).tapMenu)
//            .disposed(by: self.disposeBag)
//        self.navigationBar.addButtonToRight(image: R.image.nav_search()).rx.tap
//            .subscribeNext(weak: self, type(of: self).tapSearch)
//            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.brightColor }, to: self.paging.view.rx.backgroundColor)
            .bind({ $0.primaryColor }, to: [self.paging.rx.indicatorColor, self.paging.rx.selectedTextColor])
            .bind({ $0.titleColor }, to: self.paging.rx.textColor)
            .disposed(by: self.rx.disposeBag)
//        themeService.typeStream.delay(.milliseconds(10),
        // scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
//            guard let `self` = self else { return }
//            self.paging.reloadMenu()
//        }).disposed(by: self.rx.disposeBag)
    }
    
    func bind(reactor: SearchResultViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }

}

extension SearchResultViewController: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return self.reactor!.currentState.pages.count
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: self.reactor!.currentState.pages[index].title)
    }

    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        switch self.reactor!.currentState.pages[index] {
        case .repos:
            return self.navigator.viewController(
                for: Router.urlString(host: .repos).url!
                    .appendingPathComponent(Router.Path.search.rawValue)
                    .appendingQueryParameters([
                        Parameter.keyword: self.reactor!.keyword,
                        Parameter.hideNavBar: true.string
                    ])
            )!
        case .users:
            return self.navigator.viewController(
                for: Router.urlString(host: .users).url!
                    .appendingPathComponent(Router.Path.search.rawValue)
                    .appendingQueryParameters([
                        Parameter.keyword: self.reactor!.keyword,
                        Parameter.hideNavBar: true.string
                    ])
            )!
        }
    }

}
