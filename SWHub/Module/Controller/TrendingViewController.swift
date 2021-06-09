//
//  TrendingViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit
import Parchment
import SnapKit
import SideMenu

class TrendingViewController: ScrollViewController, ReactorKit.View {
    
    lazy var paging: NavigationBarPagingViewController = {
        let paging = NavigationBarPagingViewController()
        paging.menuBackgroundColor = .clear
        paging.menuHorizontalAlignment = .center
        paging.borderOptions = .hidden
        paging.menuItemSize = .selfSizing(estimatedWidth: 100, height: UINavigationBar.height)
        return paging
    }()

    init(_ navigator: NavigatorType, _ reactor: TrendingViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(self.paging)
        self.view.addSubview(self.paging.view)
        let tabBarHeight = self.tabBarController?.tabBar.height ?? 0
        self.paging.view.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(self.contentTop)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabBarHeight)
        }
        self.paging.didMove(toParent: self)
        self.paging.dataSource = self

        self.paging.collectionView.size = CGSize(width: self.view.width, height: UINavigationBar.height)
        self.navigationBar.titleView = self.paging.collectionView

        // v1.0.0版本屏蔽该功能，完善功能后下个版本打开
//        self.navigationBar.addButtonToLeft(image: R.image.nav_menu()).rx.tap
//            .subscribeNext(weak: self, type(of: self).tapMenu)
//            .disposed(by: self.disposeBag)
        self.navigationBar.addButtonToRight(image: R.image.nav_search()).rx.tap
            .subscribeNext(weak: self, type(of: self).tapSearch)
            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.brightColor }, to: self.paging.view.rx.backgroundColor)
            .bind({ $0.primaryColor }, to: [self.paging.rx.indicatorColor, self.paging.rx.selectedTextColor])
            .bind({ $0.titleColor }, to: self.paging.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    func bind(reactor: TrendingViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    func tapSearch(event: ControlEvent<Void>.Element) {
        self.navigator.present(
            Router.urlString(host: .search).url!
                .appendingPathComponent(Router.Path.history.rawValue),
            wrap: NavigationController.self,
            animated: false
        )
    }
    
    func tapMenu(event: ControlEvent<Void>.Element) {
        let url = Router.urlString(host: .popup).url!
            .appendingPathComponent(Router.Path.menu.rawValue)
        (self.navigator as? Navigator)?.rx.open(url)
            .subscribeNext(weak: self, type(of: self).menuResult)
            .disposed(by: self.disposeBag)
    }
    
    func menuResult(event: Event<Any>.Element) {
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func handle(_ languages: [Language]) {
        Language.storeArray(languages)
    }

}

extension TrendingViewController: PagingViewControllerDataSource {

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
                    .appendingPathComponent(Router.Path.trending.rawValue)
            )!
        case .users:
            return self.navigator.viewController(
                for: Router.urlString(host: .users).url!
                    .appendingPathComponent(Router.Path.trending.rawValue)
            )!
        }
    }

}

class NavigationBarPagingView: PagingView {

    override func setupConstraints() {
        pageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

}

class NavigationBarPagingViewController: PagingViewController {

    override func loadView() {
        view = NavigationBarPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }

}
