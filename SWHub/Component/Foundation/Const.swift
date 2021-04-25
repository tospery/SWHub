//
//  Const.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import Foundation

let basicParameters: [String: Any] = [
    "source": 1,
    "channel": (UIApplication.shared.inferredEnvironment == .debug
                    ? 1 : (UIApplication.shared.inferredEnvironment
                            == .testFlight ? 2 : 3)),
    "app_type": 1,
    "app_version": UIApplication.shared.version!,
    "device_id": UIDevice.current.uuid
]
