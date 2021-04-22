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
    
}
