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
@_exported import BonMot
@_exported import QMUIKit
@_exported import ReactorKit
@_exported import ReusableKit
@_exported import ObjectMapper
@_exported import URLNavigator
@_exported import Rswift
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
        let reactor = TabBarReactor(self.provider, nil)
        let controller = TabBarController(self.navigator, reactor)
        self.window.rootViewController = controller
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Test
    func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
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
        // 主题
        // 绑定
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
        let patterns = Router.exportedURLSchemes().map { $0.pattern }
        if self.navigator.matcher.match(url, from: patterns) != nil {
            return self.navigator.forward(url) != nil
        }
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
