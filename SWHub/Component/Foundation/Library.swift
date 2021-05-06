//
//  Library.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class Library: SWFrame.Library {

    override class func setup() {
        super.setup()
        self.setupCocoaLumberjack()
        self.setupUmbrella()
        self.setupKeyboardManager()
        self.setupToast()
        self.setupUMeng()
    }

    static func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger = DDFileLogger.init()
        fileLogger.rollingFrequency = 60 * 60 * 24
        fileLogger.maximumFileSize = 1024 * 1024 * 1
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    static func setupUmbrella() {
    }
    
    static func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    static func setupToast() {
        ToastManager.shared.position = .center
        ToastManager.shared.isQueueEnabled = true
    }
    
    static func setupUMeng() {
//        #if DEBUG
//        log("调试模式下友盟不启用", module: .library)
//        #else
//        #endif
        // 初始化基础组件库
        UMConfigure.initWithAppkey(Platform.umeng.appKey, channel: UIApplication.shared.inferredEnvironment.description)
        // 初始化U-Share及第三方平台
        UMSocialGlobal.shareInstance()?.universalLinkDic = [
            UMSocialPlatformType.wechatSession.rawValue: Platform.weixin.appLink
        ]
        UMSocialManager.default()?.setPlaform(
            .wechatSession,
            appKey: Platform.weixin.appId,
            appSecret: Platform.weixin.appKey,
            redirectURL: UIApplication.shared.baseWebUrl
        )
    }

}
