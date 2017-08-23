//
//  AmplitudeManager.swift
//  swc
//
//  Created by Arsen Gasparyan on 11/05/16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import Foundation
import Amplitude

class AmplitudeAnalyticsManager: AnalyticsProtocol {
    fileprivate let amplitude: Amplitude! = Amplitude.instance()
    
    init(apiKey: String) {
        amplitude.initializeApiKey(apiKey)
        amplitude.eventUploadPeriodSeconds = Int32(ConfigManager.analyticsFlushTime)
    }
    
    func app(_ app: UIApplication, launchedWithOptions launchOptions: [AnyHashable: Any]) {}
    
    func appDidBecomeActive() {
        amplitude.setOffline(false)
    }
    
    func appDidEnterBackground() {
        amplitude.setOffline(true)
    }
    
    func set(profile: Profile) {
        amplitude.setUserId(String(profile.id))
        amplitude.identify(identifyFor(profile: profile))
        fetchStepsHistoryIfneeded()
    }

    func removeProfile() {
        amplitude.setUserId(nil)
    }
    
    func addUserProperty(_ key: String, value: NSObject) {
        amplitude.identify(AMPIdentify().set(key, value: value))
    }

    func addUserPropertyOnce(_ key: String, value: NSObject) {
        amplitude.identify(AMPIdentify().setOnce(key, value: value))
    }
    
    func log(event: String, params: [String: String], outOfSession: Bool) {
        amplitude.logEvent(event, withEventProperties: params, outOfSession: outOfSession)
    }
    
    func log(screen: String, params: [String: String]) {
        var parameters = params
        parameters["Title"] = screen
        amplitude.logEvent("Screen Shown", withEventProperties: parameters)
    }
    
    func log(revenue: Double, product: String, contentType: String) {
        let revenue = AMPRevenue().setProductIdentifier(product)
            .setQuantity(1).setPrice(revenue as NSNumber!).setRevenueType(contentType)
        
        amplitude.logRevenueV2(revenue)
    }
    
    func log(event: AnalyticsEvents) {
        amplitude.logEvent(event.key, withEventProperties: event.params, outOfSession: event.outOfSession)
    }

}

private extension AmplitudeAnalyticsManager {
    // MARK: Helpers
    var fullPowerMode: Bool {
        return Defaults.trackerMode == .fullPower
    }
    
    var remoteNotificationsEnabled: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    func identifyFor(profile: Profile) -> AMPIdentify {
        let identify = AMPIdentify()
        if let level = profile.subscription {
            identify.set("membership", value: level.name.lowercased() as NSObject!)
        } else {
            identify.set("membership", value: "" as NSObject!)
        }

        if let date = profile.registeredAt {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            identify.set("registration_date", value: dateFormatter.string(from: date as Date) as NSObject!)
        } else {
            identify.set("registration_date", value: "" as NSObject!)
        }
        
        if let country = profile.countryOfOrigin {
            identify.set("country_of_origin", value: country.lowercased() as NSObject!)
        } else {
            identify.set("country_of_origin", value: "" as NSObject!)
        }
        
        if let country = profile.countryOfPresence {
            identify.set("country_of_presence", value: country.lowercased() as NSObject!)
        } else {
            identify.set("country_of_presence", value: "" as NSObject!)
        }
        
        identify.set("current_balance", value: String(format: "%.2f", profile.balance) as NSObject!)
        identify.set("following", value: profile.followeesCount as NSObject!)
        identify.set("followers", value: profile.followersCount as NSObject!)
        identify.set("battery_save_mode", value: !fullPowerMode as NSObject!)
        identify.set("push_allowed", value: remoteNotificationsEnabled as NSObject!)
        identify.set("total_coins_spent", value:
            String(format: "%.2f", Float(profile.spentSweatcoins)) as NSObject!)
        
        let companies = profile.companies.map { $0.title }.flatMap { $0 }
        identify.set("company", value: companies as NSObject!)
        identify.set("user_id", value: profile.id as NSObject!)
        
        return identify
    }
    
    func fetchStepsHistoryIfneeded() {
        let analyticsRequested = Defaults.healthKitAnalyticsRequested
        let healthKitRequested = Defaults.healthKitRequested
        
        guard case let .authorized(profile, _) = Session.state,
            let registeredAt = profile.registeredAt, !analyticsRequested && healthKitRequested else { return }
        Defaults.healthKitAnalyticsRequested = true
        
        func historyFor(days: Int, applyToKey key: String) {
            let endDate = Calendar.current.startOfDay(for: registeredAt).addingTimeInterval(-86_400)
            let startDate = endDate.addingTimeInterval(-86_400 * Double(days - 1))
            
            StepsHistoryManager.sharedManager.avgStepsFromDate(startDate, toDate: endDate) { completed, steps in
                guard let steps = steps, completed else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.amplitude.identify(AMPIdentify().set(key, value: steps as NSObject!))
                }
            }
        }
        
        historyFor(days: 7, applyToKey: "steps_before_week")
        historyFor(days: 30, applyToKey: "steps_before_1month")
        historyFor(days: 90, applyToKey: "steps_before_3month")
    }
}
