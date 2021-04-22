//
//  Function.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

func update<T: Subjective>(_ type: T.Type, _ value: T?) {
    if let value = value {
        value.save(ignoreId: true)
    } else {
        T.eraseObject()
    }
    Subjection.for(type).accept(value)
}

func compare(_ left: ImageSource?, _ right: ImageSource?) -> Bool {
    if let lImage = left as? UIImage,
       let rImage = right as? UIImage {
        return lImage == rImage
    }
    if let lURL = left as? URL,
       let rURL = right as? URL {
        return lURL == rURL
    }
    return false
}

func log(
    _ message: @autoclosure () -> Any,
    module: LogModule = .common,
    level: DDLogLevel = DDDefaultLogLevel,
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
        module: module.rawValue,
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
