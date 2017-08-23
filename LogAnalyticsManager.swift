//
//  LogAnalyticsManager.swift
//  swc
//
//  Created by Egor Khmelev on 10.05.16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import UIKit

class LogAnalyticsManager: AnalyticsProtocol {

    func app(_ app: UIApplication, launchedWithOptions launchOptions: [AnyHashable: Any]) {
        #if DEBUG
            DDLog.add(DDASLLogger.sharedInstance())
        #endif
        
        let logFileManager = SWCLogFileManager(logsDirectory: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let fileLogger = DDFileLogger(logFileManager: logFileManager)
        fileLogger?.rollingFrequency = 3_600 * 1
        fileLogger?.logFileManager.maximumNumberOfLogFiles = 48
        
        DDLog.add(fileLogger)
    }
    
    func appDidBecomeActive() {
    }
    
    func appDidEnterBackground() {
    }
    
    func set(profile: Profile) {}
    func removeProfile() {}
    func addUserProperty(_ key: String, value: NSObject) {
        DDLogInfo("Set property \(key): \(value)")
    }

    func addUserPropertyOnce(_ key: String, value: NSObject) {
        DDLogInfo("Set property once \(key): \(value)")
    }

    func log(event: String, params: [String: String], outOfSession: Bool) {
        DDLogInfo("\(CurrentFileName()) logEvent: \(event) params: \(params)")
    }

    func log(screen: String, params: [String: String]) {
        DDLogInfo("\(CurrentFileName()) logScreenView: \(screen) params: \(params)")
    }

    func log(revenue: Double, product: String, contentType: String) {
        DDLogInfo("\(CurrentFileName()) logRevenue: \(product) revenue: \(revenue) contentType: \(contentType)")
    }
    
    func log(event: AnalyticsEvents) {
        DDLogInfo("\(CurrentFileName()) logEvent: \(event.key) params: \(event.params)")
    }

}
