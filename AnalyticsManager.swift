//
//  AnalyticsManager.swift
//  swc
//
//  Created by Arsen Gasparyan on 06/03/16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import UIKit
import WatchConnectivity

class AnalyticsManager: NSObject {
    static let sharedManager = AnalyticsManager()
    
    var providers = [AnalyticsProtocol]()
    var trackPushTokenReceived = false
    
    class func set(profile: Profile) {
        sharedManager.providers.forEach { $0.set(profile: profile) }

        let watch = WCSession.default()
        let experiments: NSArray = profile.experiments as NSArray
        addUserProperty("experiments", value: experiments)
        addUserProperty("watch.is_paired", value: watch.isPaired as NSObject)
        addUserProperty("watch.app_installed", value: watch.isWatchAppInstalled as NSObject)
    }
    
    class func removeProfile() {
        sharedManager.providers.forEach { $0.removeProfile() }
    }
    
    class func log(event: AnalyticsEvents) {
        sharedManager.providers.forEach { $0.log(event: event) }
    }
    
    class func log(event: String) {
        sharedManager.providers.forEach { logger in
            logger.log(event: event, params: [String: String](), outOfSession: false)
        }
    }
    
    class func log(event: String, params: [String: String]) {
        sharedManager.providers.forEach { logger in
            logger.log(event: event, params: params, outOfSession: false)
        }
    }

    class func log(name: String, params: [String: String], outOfSession: Bool) {
        sharedManager.providers.forEach { logger in
            logger.log(event: name, params: params, outOfSession: outOfSession)
        }
    }
    
    class func log(screen: String) {
        sharedManager.providers.forEach { $0.log(screen: screen, params: [String: String]()) }
    }
    
    class func log(screen: String, params: [String: String]) {
        sharedManager.providers.forEach { $0.log(screen: screen, params: params) }
    }
    
    class func logOfferPurchase(_ offer: Offer, marketplace: String) {
        sharedManager.providers.forEach {
            $0.log(revenue: Double(offer.price), product: "offer.\(offer.id)", contentType: "offer_purchase")
        }
        
        log(event: .offerPurcahseSuccess(offer: offer, marketplace: marketplace))
    }
    
    class func logUpgradeToMembership(_ membership: Subscription!, from: Subscription!) {
        guard let membership = membership, let from = from else { return }
        sharedManager.providers.forEach {
            $0.log(revenue: Double(membership.price), product: "membership.\(membership.name)", contentType: "membership_upgrade")
        }
        
        log(event: .membershipUpgradeSuccess(from: from, to: membership))
    }
    
    class func logCoinTransfer(_ recipient: String, revenue: Double) {
        sharedManager.providers.forEach {
            $0.log(revenue: revenue, product: "coin_transfer.\(recipient)", contentType: "coin_transfer")
        }
        
        log(event: .sentCoinsTranferSuccess(recipient: recipient, amount: revenue))
    }
    
    class func logWalkchainSubmit(_ walkchain: Walkchain!) {
        guard let walkchain = walkchain else { return }
        log(event: .walkchainAccepted(walkchain: walkchain))
    }
    
    class func addUserProperty(_ key: String, value: NSObject!) {
        guard let value = value else { return }
        sharedManager.providers.forEach {
            $0.addUserProperty(key, value: value)
        }
    }

    class func addUserPropertyOnce(_ key: String, value: NSObject!) {
        guard let value = value else { return }
        sharedManager.providers.forEach {
            $0.addUserPropertyOnce(key, value: value)
        }
    }
}
