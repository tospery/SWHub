//
//  Function.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import CocoaLumberjack

func log(
    _ message: @autoclosure () -> Any,
    module: Logger.Module = .common,
    level: DDLogLevel = .debug,
    flag: DDLogFlag = .debug,
    context: Int = 0,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line,
    tag: Any? = nil,
    asynchronous async: Bool = asyncLoggingEnabled,
    ddlog: DDLog = .sharedInstance
) {
    logger.print(
        message(),
        module: module,
        level: level,
        flag: flag,
        context: context,
        file: file,
        function: function,
        line: line,
        tag: tag,
        asynchronous: async,
        ddlog: ddlog
    )
}
