//
//  FacebookAnalyticsManager.swift
//  swc
//
//  Created by Arsen Gasparyan on 06/03/16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import UIKit

class FacebookAnalyticsManager: NSObject, AnalyticsProtocol {

    func appDidBecomeActive() {
        FBSDKAppEvents.activateApp()
        FBSDKAppEvents.setFlushBehavior(.auto)
    }
    
    func app(_ app: UIApplication, launchedWithOptions launchOptions: [AnyHashable: Any]) {
        FBSDKApplicationDelegate.sharedInstance().application(app, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func appDidEnterBackground() {
        FBSDKAppEvents.setFlushBehavior(.explicitOnly)
    }
    
    func set(profile: Profile) {}
    func removeProfile() {}
    func addUserProperty(_ key: String, value: NSObject) { }
    func addUserPropertyOnce(_ key: String, value: NSObject) { }
    
    func log(event: String, params: [String: String], outOfSession: Bool) {
        var parameters = params
        parameters["Title"] = event
        FBSDKAppEvents.logEvent("Button Pressed", parameters: parameters)
    }
    
    func log(screen: String, params: [String: String]) {
        var parameters = params
        parameters["Title"] = screen
        FBSDKAppEvents.logEvent("Screen Shown", parameters: parameters)
    }
    
    func log(revenue: Double, product: String, contentType: String) {
        FBSDKAppEvents.logPurchase(Double(revenue), currency: "SWC", parameters:
            [FBSDKAppEventParameterNameContentType: contentType,
             FBSDKAppEventParameterNameContentID: product])
    }
    
    func log(event: AnalyticsEvents) {
        let name = event.key.replacingOccurrences(of: ".", with: "_")
        FBSDKAppEvents.logEvent(name, parameters: event.params)
    }
    
}
