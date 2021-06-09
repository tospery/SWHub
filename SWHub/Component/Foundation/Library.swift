//
//  Library.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import CocoaLumberjack
import IQKeyboardManagerSwift
import Toast_Swift
import PopupDialog
import MJRefresh

class Library: SWFrame.Library {

    override class func setup() {
        super.setup()
        self.setupCocoaLumberjack()
        self.setupUmbrella()
        self.setupKeyboardManager()
        self.setupToast()
        self.setupPopupDialog()
        self.setupUMeng()
        self.setupMJRefresh()
    }

    static func setupCocoaLumberjack() {
        #if DEBUG
        log("调试模式开启所有日志", module: .library)
        #else
        dynamicLogLevel = .info
        #endif
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
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    static func setupToast() {
        ToastManager.shared.position = .center
        ToastManager.shared.isQueueEnabled = true
    }
    
    static func setupPopupDialog() {
        // Dialog Default View Appearance Settings
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor    = .background
        dialogAppearance.titleColor         = .title
        dialogAppearance.titleFont          = .bold(16)
        dialogAppearance.messageColor       = .body
        dialogAppearance.messageFont        = .normal(15)

        // Dialog Container Appearance Settings
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.backgroundColor = .background

        // Overlay View Appearance Settings
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color             = .dim
        overlayAppearance.blurEnabled       = false
        overlayAppearance.liveBlurEnabled   = false
        overlayAppearance.opacity           = 0.7

        // Button Appearance Settings
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleColor  = .primary
        defaultButtonAppearance.titleFont   = .normal(16)
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleColor  = .footer
        cancelButtonAppearance.titleFont   = .normal(16)
        let destructiveButtonAppearance = DestructiveButton.appearance()
        destructiveButtonAppearance.titleColor  = .primary
        destructiveButtonAppearance.titleFont   = .normal(16)
    }
    
    static func setupUMeng() {
        #if DEBUG
        log("调试模式下友盟不启用", module: .library)
        #else
        // 初始化基础组件库
        UMConfigure.initWithAppkey(Platform.umeng.appKey, channel: UIApplication.shared.inferredEnvironment.description)
        // 初始化U-Share及第三方平台
//        UMSocialGlobal.shareInstance()?.universalLinkDic = [
//            UMSocialPlatformType.wechatSession.rawValue: Platform.weixin.appLink
//        ]
//        UMSocialManager.default()?.setPlaform(
//            .wechatSession,
//            appKey: Platform.weixin.appId,
//            appSecret: Platform.weixin.appKey,
//            redirectURL: UIApplication.shared.baseWebUrl
//        )
        #endif
    }

    static func setupMJRefresh() {
        MJRefreshConfig.default().languageCode = "en-US"
    }
    
}
