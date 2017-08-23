//
//  AnalyticsProtocol.swift
//  swc
//
//  Created by Arsen Gasparyan on 06/03/16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import Foundation

protocol AnalyticsProtocol {
    func app(_ app: UIApplication, launchedWithOptions launchOptions: [AnyHashable: Any])
    func appDidBecomeActive()
    func appDidEnterBackground()
    func set(profile: Profile)
    func removeProfile()
    func addUserProperty(_ key: String, value: NSObject)
    func addUserPropertyOnce(_ key: String, value: NSObject)
    func log(event: String, params: [String: String], outOfSession: Bool)
    func log(screen: String, params: [String: String])
    func log(revenue: Double, product: String, contentType: String)
    
    func log(event: AnalyticsEvents)
}
