//
//  TabBarController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class TabBarController: SWFrame.TabBarController, ReactorKit.View {

    init(_ navigator: NavigatorType, _ reactor: TabBarReactor) {
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
        themeService.rx
            .bind({ $0.lightColor }, to: self.tabBar.rx.barTintColor)
            .bind({ $0.primaryColor }, to: self.tabBar.rx.tintColor)
            .bind({ $0.titleColor }, to: self.tabBar.rx.unselectedItemTintColor)
            .disposed(by: self.rx.disposeBag)
    }

    func bind(reactor: TabBarReactor) {
        super.bind(reactor: reactor)
        reactor.state.map { $0.keys }
            .takeUntil(self.rx.viewDidLoad)
            .subscribe(onNext: { [weak self] keys in
                guard let `self` = self else { return }
                self.viewControllers = keys.map {
                    NavigationController(rootViewController: self.viewController(with: $0))
                }
            })
            .disposed(by: self.disposeBag)
    }

    func viewController(with key: TabBarKey) -> BaseViewController {
        var viewController: BaseViewController!
        switch key {
        case .home:
            viewController = HomeViewController(self.navigator, HomeViewReactor(self.reactor!.provider, nil))
            viewController.tabBarItem.image = R.image.tabbar_home_normal()?.original
            viewController.tabBarItem.selectedImage = R.image.tabbar_home_selected()?.original
        case .mine:
            viewController = MineViewController(self.navigator, MineViewReactor(self.reactor!.provider, nil))
            viewController.tabBarItem.image = R.image.tabbar_mine_normal()?.original
            viewController.tabBarItem.selectedImage = R.image.tabbar_mine_selected()?.original
        }
        viewController.hidesBottomBarWhenPushed = false
        return viewController!
    }

}
