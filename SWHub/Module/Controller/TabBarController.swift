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
        self.delegate = self
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

    func viewController(with key: TabBarKey) -> UIViewController {
        var viewController: UIViewController!
        var parameters = [String: String].init()
        parameters[Parameter.title] = key.title
        switch key {
        case .trending:
            viewController = TrendingViewController(
                self.navigator,
                TrendingViewReactor(self.reactor!.provider, parameters)
            )
        case .events:
            viewController = BaseViewController.init(
                self.navigator,
                BaseViewReactor.init(self.reactor!.provider, parameters)
            )
        case .stars:
            viewController = self.navigator.viewController(
                for: Router.urlString(host: .repos).url!
                    .appendingPathComponent(Router.Path.stars.rawValue)
                    .appendingQueryParameters([
                        Parameter.username: User.current?.username ?? ""
                    ])
            )!
        case .me:
            viewController = self.navigator.viewController(
                for: Router.urlString(host: .center)
            )!
        }
        viewController.tabBarItem.image = key.image.template
        viewController.tabBarItem.selectedImage = key.image.template
        viewController.hidesBottomBarWhenPushed = false
        return viewController!
    }

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        if let nav = viewController as? NavigationController,
           let top = nav.topViewController as? ListViewController,
           (top.reactor?.host == .repos && top.reactor?.path == .stars),
           (top.reactor?.username == nil || top.reactor?.username.isEmpty ?? true) {
            self.navigator.present(
                Router.urlString(host: .login),
                wrap: NavigationController.self
            )
            return false
        }
        return true
    }
}
