//
//  AppDependency.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/3/27.
//

import UIKit
@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxOptional
@_exported import RxSwiftExt
@_exported import NSObject_Rx
@_exported import RxDataSources
@_exported import RxViewController
@_exported import RxTheme
@_exported import Moya
@_exported import Cache
@_exported import BonMot
@_exported import QMUIKit
@_exported import ReactorKit
@_exported import ReusableKit
@_exported import ObjectMapper
@_exported import URLNavigator
@_exported import Rswift
@_exported import Alamofire
@_exported import Kingfisher
@_exported import SwifterSwift
@_exported import SwiftEntryKit
@_exported import CocoaLumberjack
@_exported import IQKeyboardManagerSwift
@_exported import Toast_Swift
@_exported import Umbrella
@_exported import SWFrame

final class AppDependency: AppDependencyType {

    let navigator: NavigatorType
    let provider: SWFrame.ProviderType
    let disposeBag = DisposeBag()
    var window: UIWindow!
    
    static var shared = AppDependency()

    // MARK: - Initialize
    init() {
        self.navigator = Navigator.init()
        self.provider = Provider.init()
    }

    func initialScreen(with window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        self.window = window
        var rootViewController: UIViewController?
        if User.current?.isValid ?? false {
            let reactor = TabBarReactor(self.provider, nil)
            rootViewController = TabBarController(self.navigator, reactor)
        } else {
            let reactor = LoginViewReactor.init(self.provider, nil)
            let controller = LoginViewController.init(self.navigator, reactor)
            rootViewController = NavigationController.init(rootViewController: controller)
        }
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func handle(user: User?) {
        var rootViewController: UIViewController?
        if user?.isValid ?? false {
            let reactor = TabBarReactor(self.provider, nil)
            rootViewController = TabBarController(self.navigator, reactor)
        } else {
            let reactor = LoginViewReactor.init(self.provider, nil)
            let controller = LoginViewController.init(self.navigator, reactor)
            rootViewController = NavigationController.init(rootViewController: controller)
        }
        let transtition = CATransition.init()
        transtition.duration = 0.5
        transtition.timingFunction = .init(name: .easeOut)
        self.window.layer.add(transtition, forKey: "animation")
        self.window.rootViewController = rootViewController
    }
    
    // MARK: - Test
    func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//        self.provider.login(token: "").subscribe { user in
//            let aaa = user
//            log("a")
//        } onError: { error in
//            let bbb = error
//            log("b")
//        }.disposed(by: self.disposeBag)
    }
    
    // MARK: - Lifecycle
    func application(
        _ application: UIApplication,
        entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        // 初始化
        Runtime.work()
        Library.setup()
        Appearance.config()
        Router.initialize(self.provider, self.navigator)
        // 绑定
        Subjection.for(User.self).asObservable()
            .skip(1)
            .distinctUntilChanged { $0?.isValid ?? false != $1?.isValid ?? false }
            .observeOn(MainScheduler.instance)
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
    }

    func application(
        _ application: UIApplication,
        leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        #if DEBUG
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.test(launchOptions: launchOptions)
        }
        #endif
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - URL
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any]
    ) -> Bool {
        return true
    }

    // MARK: - userActivity
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return true
    }
    
}
