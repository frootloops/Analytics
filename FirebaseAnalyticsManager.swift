//
//  FirebaseAnalyticsManager.swift
//  swc
//
//  Created by Egor Khmelev on 31/01/2017.
//  Copyright © 2017 SweatCo LTD. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAnalyticsManager: AnalyticsProtocol {

    func app(_ app: UIApplication, launchedWithOptions launchOptions: [AnyHashable: Any]) {}
    func appDidEnterBackground() {}
    func appDidBecomeActive() {
        FIRAnalytics.logEvent(withName: kFIREventAppOpen, parameters: nil)
    }
    
    func set(profile: Profile) {
        FIRAnalytics.setUserID(String(profile.id))
        
        if let level = profile.subscription {
            FIRAnalytics.setUserPropertyString(level.name.lowercased(), forName: "membership")
        }
        
        if let date = profile.registeredAt {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            FIRAnalytics.setUserPropertyString(dateFormatter.string(from: date as Date), forName: "registration_date")
        }
        
        if let country = profile.countryOfOrigin {
            FIRAnalytics.setUserPropertyString(country.lowercased(), forName: "country_of_origin")
        }
        
        FIRAnalytics.setUserPropertyString(String(format: "%.2f", profile.balance), forName: "current_balance")
        FIRAnalytics.setUserPropertyString(profile.followeesCount.description, forName: "following")
        FIRAnalytics.setUserPropertyString(profile.followersCount.description, forName: "followers")
        FIRAnalytics.setUserPropertyString((!fullPowerMode).description, forName: "battery_save_mode")
        FIRAnalytics.setUserPropertyString(remoteNotificationsEnabled.description, forName: "push_allowed")
        FIRAnalytics.setUserPropertyString(String(format: "%.2f", Float(profile.spentSweatcoins)), forName: "total_coins_spent")
        
        let companies = profile.companies.map { $0.title }.flatMap { $0 }.joined(separator: ";")
        FIRAnalytics.setUserPropertyString(companies, forName: "company")
    }
    
    func removeProfile() {
        FIRAnalytics.setUserID(nil)
    }
    
    func addUserProperty(_ key: String, value: NSObject) {
        if let value = value as? String {
            FIRAnalytics.setUserPropertyString(value, forName: transformedKey(key))
        } else if let value = value as? [String] {
            FIRAnalytics.setUserPropertyString(value.joined(separator: ";"), forName: transformedKey(key))
        } else if let value = value as? Bool {
            FIRAnalytics.setUserPropertyString(value.description, forName: transformedKey(key))
        }
    }
    
    func addUserPropertyOnce(_ key: String, value: NSObject) {
        if let value = value as? String {
            FIRAnalytics.setUserPropertyString(value, forName: transformedKey(key))
        } else if let value = value as? [String] {
            FIRAnalytics.setUserPropertyString(value.joined(separator: ";"), forName: transformedKey(key))
        } else if let value = value as? Bool {
            FIRAnalytics.setUserPropertyString(value.description, forName: transformedKey(key))
        }
    }
    
    func log(event: String, params: [String: String], outOfSession: Bool) {
        FIRAnalytics.logEvent(withName: transformedKey(event), parameters: params as [String : NSObject]?)
    }
    
    func log(screen: String, params: [String: String]) {
        var parameters = params
        parameters["Title"] = screen
        FIRAnalytics.logEvent(withName: "screen_shown", parameters: parameters as [String : NSObject]?)
    }
    
    func log(revenue: Double, product: String, contentType: String) {
        FIRAnalytics.logEvent(withName: kFIREventSpendVirtualCurrency, parameters: [
            kFIRParameterItemName: product as NSObject,
            kFIRParameterVirtualCurrencyName: "SWC" as NSObject,
            kFIRParameterValue: revenue as NSNumber
        ])
    }
    
    func log(event: AnalyticsEvents) {
        FIRAnalytics.logEvent(withName: transformedKey(event.key), parameters: event.params as? [String : NSObject])
    }
}

private extension FirebaseAnalyticsManager {
    // MARK: Helpers
    var fullPowerMode: Bool {
        return Defaults.trackerMode == .fullPower
    }
    
    var remoteNotificationsEnabled: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    func transformedKey(_ key: String) -> String {
        return key.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: " ", with: "_").lowercased()
    }
}
