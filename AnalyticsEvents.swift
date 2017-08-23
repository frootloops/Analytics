//
//  AnalyticsEvents.swift
//  swc
//
//  Created by Arsen Gasparyan on 16/07/16.
//  Copyright © 2016 SweatCo LTD. All rights reserved.
//

import Foundation
import CoreLocation

enum AnalyticsEvents {
    enum OnboardingType: String {
        case SignUp = "registration", SignIn = "login"
    }
    
    case appLaunch
    case appOpen(fromPush: Bool)
    case appClose
    case appTerminate
    case appUnauthorize
    
    case menuOpenMarketplace
    case menuOpenWallet
    case menuOpenTracking
    case menuOpenLeaderboard
    case menuOpenProfile
    
    case introLoginSuccess(type: OnboardingType)
    case introNameSubmitted
    case introStepDetectionAllowed
    case introGPSAllowed
    case introPhoneSubmitted
    case introSmsCodeSubmitted
    case introEmailSubmitted
    case introReadTC
    case introAcceptTC
    case introMoreInfo
    case introEarnMore
    case introMotionAccessAllowed
    case introLocationAccessAllowed
    case introAllowHealthkitForWatch
    case introSkipHealthkitForWatch
    case introError(reason: String)
    
    case allowPushAppear
    case allowPushAllow
    case allowPushDisallow
    case allowPushSystemAllow
    
    case upgadeMembershipAppear
    case upgradeMembershipShowDetails
    
    case membershipUpgradeLevel(from: Subscription, to: Subscription)
    case membershipUpgradeSuccess(from: Subscription, to: Subscription)
    case membershipError(from: Subscription, to: Subscription, reason: String)
    
    case marketplaceOpenOffer(offer: Offer, marketplace: String)
    case marketplaceShowMore(marketplace: String)
    
    case offerOpenSite(offer: Offer, url: String)
    case offerPurchaseAttempt(offer: Offer, marketplace: String)
    case offerPurcahseSuccess(offer: Offer, marketplace: String)
    case offerPurchaseError(offer: Offer, marketplace: String, reason: String)
    case offerSlidePhoto(offer: Offer)
    case offerDonationAttempt(offer: Offer, marketplace: String)
    case offerShowMoreInviteOptions
        
    case walletSendCoins
    case walletOpenEarnings
    case walletOpenIn
    case walletOpenOut
    case walletOpenAll
    case walletChangeTransactionType(type: String)
    
    case sentCoinsTranferSuccess(recipient: String, amount: Double)
    case sentCoinsError(recipient: String, amount: Double, reason: String)
    case sendCoinsUserSelected
    case sendCoinsAmountSelected
    
    case leaderboardChooseInterval(interval: String)
    case leaderboardChooseKind(kind: String)
    case leaderboardOpenUserProfile(userId: Int)
    case leaderboardSlide(leaderboard: String)
    case leaderboardAddFriend
    case leaderboardOpenUser(leaderboard: String)
    case leaderboardConsoleAppear
    case leaderboardConsoleWillConnectPhonebook
    case leaderboardConsoleDidConnectPhonebook(contacts: Int)
    case leaderboardConsoleSkipPhonebook
    case leaderboardConsoleWillConnectFacebook
    case leaderboardConsoleDidConnectFacebook(contacts: Int)
    case leaderboardConsoleSkipFacebook
    case leaderboardConsoleClose
    case leaderboardConsoleOpenFindFriends(page: FindFriendsContainerController.Page)
    
    case userProfileSendCoins
    case userProfileOpenMembership(me: Bool)
    case userProfileOpenOffer(offer: Offer)
    case userProfileFollow(action: String)
    
    case settingsChangeCountry
    case settingsCountryChanged(source: String, target: String)
    case settingsBatterySaverMode(mode: Bool)
    case settingsPushNotification(mode: Bool)
    
    case rateAppAppear
    case rateAppRatingSent(rating: Int)
    case rateAppRateOnAppStore
    case rateAppShareOnFacebook
    case rateAppSendFeedback
    
    case sendFeedbackSuccess
    
    case walkchainAccepted(walkchain: Walkchain)
    
    case trackingRefreshEarned
    case trackingInviteFriends
    
    case allowStepHistoryAppear
    case allowStepHistoryAllow
    
    case findFriendsInvite(action: String, source: String)
    case findFriendsConnectFacebook
    case findFriendsConnectContacts
    case findFriendsCopyLink
    case findFriendsShareLink
    case findFriendsShareLinkComplete(activityType: String?)
    case findFriendsShareOnFacebook
    case findFriendsShareOnFacebookComplete
    case findFriendsShareOnWhatsapp
    case findFriendsShareOnWhatsappComplete
    case findFriendsShareOnTwitter
    case findFriendsShareOnTwitterComplete
    case findFriendsShareViaMessage
    case findFriendsShareViaMessageComplete
    
    case branchClickedLink(matchGuaranteed: Bool)
    case firebaseClickedLink(confidence: Int)
    
    case pushNotificationOpen(pushId: String)
    
    case profileEditStartEmailEditing
    
    case emailVerifySendCode
    case emailVerifyCheckCode
    case emailVerifyDone
    
    var key: String {
        switch self {
        case .appLaunch: return "App.Launch"
        case .appOpen: return "App.Open"
        case .appClose: return "App.Close"
        case .appTerminate: return "App.Terminate"
        case .appUnauthorize: return "App.Unauthorize"
            
        case .menuOpenMarketplace: return "Menu.OpenMarketplace"
        case .menuOpenWallet: return "Menu.OpenWallet"
        case .menuOpenTracking: return "Menu.OpenTracking"
        case .menuOpenLeaderboard: return "Menu.OpenLeaderboard"
        case .menuOpenProfile: return "Menu.OpenProfile"
            
        case .introLoginSuccess: return "Intro.LoginSuccess"
        case .introNameSubmitted: return "Intro.NameSubmitted"
        case .introStepDetectionAllowed: return "Intro.StepDetectionAllowed"
        case .introGPSAllowed: return "Intro.GPSAllowed"
        case .introPhoneSubmitted: return "Intro.PhoneSubmitted"
        case .introSmsCodeSubmitted: return "Intro.SmsCodeSubmitted"
        case .introEmailSubmitted: return "Intro.EmailSubmitted"
        case .introReadTC: return "Intro.OpenTC"
        case .introAcceptTC: return "Intro.AcceptTC"
        case .introMoreInfo: return "Intro.MoreInfo"
        case .introEarnMore: return "Intro.EarnMore"
        case .introMotionAccessAllowed: return "Intro.MotionAccessAllowed"
        case .introLocationAccessAllowed: return "Intro.LocationAccessAllowed"
        case .introAllowHealthkitForWatch: return "Intro.AllowHealthkitForWatch"
        case .introSkipHealthkitForWatch: return "Intro.SkipHealthkitForWatch"
        case .introError: return "Intro.Error"
            
        case .allowPushAppear: return "AllowPush.Appear"
        case .allowPushAllow: return "AllowPush.Allow"
        case .allowPushDisallow: return "AllowPush.Disallow"
        case .allowPushSystemAllow: return "AllowPush.SystemAllow"
            
        case .upgadeMembershipAppear: return "UpgadeMembership.Appear"
        case .upgradeMembershipShowDetails: return "UpgradeMembership.ShowDetails"
            
        case .membershipUpgradeLevel: return "Membership.UpgradeLevel"
        case .membershipUpgradeSuccess: return "Membership.UpgradeSuccess"
        case .membershipError: return "Membership.Error"
            
        case .marketplaceOpenOffer: return "Marketplace.OpenOffer"
        case .marketplaceShowMore: return "Marketplace.ShowMore"
            
        case .offerOpenSite: return "Offer.OpenSite"
        case .offerPurchaseAttempt: return "Offer.PurchaseAttempt"
        case .offerPurcahseSuccess: return "Offer.PurcahseSuccess"
        case .offerPurchaseError: return "Offer.PurchaseError"
        case .offerSlidePhoto: return "Offer.SlidePhoto"
        case .offerDonationAttempt: return "Offer.DonationAttempt"
        case .offerShowMoreInviteOptions: return "Offer.ShowMoreInviteOptions"
            
        case .walletSendCoins: return "Wallet.SendCoins"
        case .walletOpenEarnings: return "Wallet.OpenEarnings"
        case .walletOpenIn: return "Wallet.OpenIn"
        case .walletOpenOut: return "Wallet.OpenOut"
        case .walletOpenAll: return "Wallet.OpenAll"
        case .walletChangeTransactionType: return "Wallet.ChangeTransactionType"
            
        case .sentCoinsTranferSuccess: return "SentCoins.TranferSuccess"
        case .sentCoinsError: return "SentCoins.Error"
        case .sendCoinsUserSelected: return "SendCoins.UserSelected"
        case .sendCoinsAmountSelected: return "SendCoins.AmountSelected"
            
        case .leaderboardChooseInterval: return "Leaderboard.ChooseInterval"
        case .leaderboardChooseKind: return "Leaderboard.ChooseKind"
        case .leaderboardOpenUserProfile: return "Leaderboard.OpenUserProfile"
        case .leaderboardSlide: return "Leaderboard.Slide"
        case .leaderboardAddFriend: return "Leaderboard.AddFriend"
        case .leaderboardOpenUser: return "Leaderboard.OpenUser"
        case .leaderboardConsoleAppear: return "LeaderboardConsole.Appear"
        case .leaderboardConsoleWillConnectPhonebook: return "LeaderboardConsole.WillConnectPhonebook"
        case .leaderboardConsoleDidConnectPhonebook: return "LeaderboardConsole.DidConnectPhonebook"
        case .leaderboardConsoleSkipPhonebook: return "LeaderboardConsole.SkipPhonebook"
        case .leaderboardConsoleWillConnectFacebook: return "LeaderboardConsole.WillConnectFacebook"
        case .leaderboardConsoleDidConnectFacebook: return "LeaderboardConsole.DidConnectFacebook"
        case .leaderboardConsoleSkipFacebook: return "LeaderboardConsole.SkipFacebook"
        case .leaderboardConsoleClose: return "LeaderboardConsole.Close"
        case .leaderboardConsoleOpenFindFriends: return "LeaderboardConsole.OpenFindFriends"
            
        case .userProfileSendCoins: return "UserProfile.SendCoins"
        case .userProfileOpenMembership: return "UserProfile.OpenMembership"
        case .userProfileOpenOffer: return "UserProfile.OpenOffer"
        case .userProfileFollow: return "UserProfile.Follow"
            
        case .settingsChangeCountry: return "Settings.ChangeCountry"
        case .settingsCountryChanged: return "Settings.CountryChanged"
        case .settingsBatterySaverMode: return "Settings.SetBatteryMode"
        case .settingsPushNotification: return "Settings.PushNotification"
            
        case .rateAppAppear: return "RateApp.Appear"
        case .rateAppRatingSent: return "RateApp.RatingSent"
        case .rateAppRateOnAppStore: return "RateApp.RateOnAppStore"
        case .rateAppShareOnFacebook: return "RateApp.ShareOnFacebook"
        case .rateAppSendFeedback: return "RateApp.SendFeedback"
            
        case .sendFeedbackSuccess: return "SendFeedback.Success"
            
        case .walkchainAccepted: return "Walkchain.Accepted"
            
        case .trackingRefreshEarned: return "Tracking.RefreshEarned"
        case .trackingInviteFriends: return "Tracking.InviteFriends"
            
        case .allowStepHistoryAppear: return "AllowStepHistory.Appear"
        case .allowStepHistoryAllow: return "AllowStepHistory.Allow"
            
        case .findFriendsInvite: return "FindFriends.Invite"
        case .findFriendsConnectFacebook: return "FindFriends.ConnectFacebook"
        case .findFriendsConnectContacts: return "FindFriendsConnect.Contacts"
        case .findFriendsCopyLink: return "FindFriends.CopyLink"
        case .findFriendsShareLink: return "FindFriends.ShareLink"
        case .findFriendsShareLinkComplete: return "FindFriends.ShareLinkComplete"
        case .findFriendsShareOnFacebook: return "FindFriends.ShareOnFacebook"
        case .findFriendsShareOnFacebookComplete: return "FindFriends.ShareOnFacebookComplete"
        case .findFriendsShareOnWhatsapp: return "FindFriends.ShareOnWhatsapp"
        case .findFriendsShareOnWhatsappComplete: return "FindFriends.ShareOnWhatsappComplete"
        case .findFriendsShareOnTwitter: return "FindFriends.ShareOnTwitter"
        case .findFriendsShareOnTwitterComplete: return "FindFriends.ShareOnTwitterComplete"
        case .findFriendsShareViaMessage: return "FindFriends.ShareViaMessage"
        case .findFriendsShareViaMessageComplete: return "FindFriends.ShareViaMessageComplete"
            
        case .branchClickedLink: return "Branch.ClickedLink"
        case .firebaseClickedLink: return "Firebase.ClickedLink"
        
        case .pushNotificationOpen: return "PushNotification.Open"
            
        case .profileEditStartEmailEditing: return "ProfileEdit.StartEmailEditing"
            
        case .emailVerifySendCode: return "EmailVerify.SendCode"
        case .emailVerifyCheckCode: return "EmailVerify.CheckCode"
        case .emailVerifyDone: return "EmailVerify.Done"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .appOpen(let fromPush): return ["from_push": fromPush]
        case .introLoginSuccess(let type): return ["type": "\(type.rawValue)"]
        case .introError(let reason): return ["reason": reason]
        case .rateAppRatingSent(let rating): return ["rating": rating]
        case .leaderboardChooseInterval(let interval): return ["interval": interval]
        case .leaderboardChooseKind(let kind): return ["kind": kind]
        case .leaderboardOpenUserProfile(let userId): return ["user_id": userId]
        case .leaderboardOpenUser(let leaderboard): return ["leaderboard": leaderboard]
        case .leaderboardConsoleOpenFindFriends(let page): return ["page": page.rawValue]
        case .leaderboardConsoleDidConnectPhonebook(let contacts): return ["contacts": contacts]
        case .leaderboardConsoleDidConnectFacebook(let contacts): return ["contacts": contacts]
            
        case .marketplaceOpenOffer(let offer, let marketplace): return offerAttributes(offer, marketplace: marketplace)
        case .userProfileOpenOffer(let offer): return offerAttributes(offer)
        case .offerSlidePhoto(let offer): return offerAttributes(offer)
        case .offerPurchaseAttempt(let offer, let marketplace): return offerAttributes(offer, marketplace: marketplace)
        case .offerPurcahseSuccess(let offer, let marketplace): return offerAttributes(offer, marketplace: marketplace)
        case .offerPurchaseError(let offer, let marketplace, let reason):
            var params = offerAttributes(offer, marketplace: marketplace)
            params["reason"] = reason
            return params
        case .offerDonationAttempt(let offer, let marketplace): return offerAttributes(offer, marketplace: marketplace)
            
        case .walkchainAccepted(let walkchain): return walkchainAttributes(walkchain)
            
        case .walletChangeTransactionType(let type): return ["type": type]
        case .marketplaceShowMore(let marketplace): return ["marketplace": marketplace]
        case .leaderboardSlide(let leaderboard): return ["leaderboard": leaderboard]
            
        case .userProfileOpenMembership(let me): return ["self": me]
            
        case .membershipUpgradeLevel(let fromLevel, let toLevel):
            return ["from_level": fromLevel.name.lowercased(), "to_level": toLevel.name.lowercased(), "price": toLevel.price]
        case .membershipError(let fromLevel, let toLevel, let reason):
            return ["from_level": fromLevel.name.lowercased(), "to_level": toLevel.name.lowercased(), "price": toLevel.price, "reason": reason]
            
        case .offerOpenSite(let offer, let url):
            var params = offerAttributes(offer)
            params["url"] = url
            return params
            
        case .sentCoinsError(let recipient, let amount, let reason):
            return ["reason": reason, "amount": String(format: "%.2f", amount), "to_user": recipient]
        case .sentCoinsTranferSuccess(let recipient, let amount):
            return ["amount": String(format: "%.2f", amount), "to_user": recipient]
        case .membershipUpgradeSuccess(let fromLevel, let toLevel):
            return ["from_level": fromLevel.name.lowercased(), "to_level": toLevel.name.lowercased(), "price": toLevel.price]
        case .userProfileFollow(let action): return ["action": action]
            
        case .findFriendsInvite(let action, let source): return ["action": action, "source": source]
        case .branchClickedLink(let matchGuaranteed): return ["match_guaranteed": matchGuaranteed]
        case .firebaseClickedLink(let confidence): return ["confidence": confidence]

        case .settingsCountryChanged(let source, let target): return ["from": source, "target": target]
        case .settingsBatterySaverMode(let mode): return ["mode": mode]
        case .settingsPushNotification(let mode): return ["mode": mode]
        
        case .pushNotificationOpen(let pushId): return ["push_id": pushId]

        case let .findFriendsShareLinkComplete(activityType):
            if let type = activityType {
                return ["activity_type": type]
            }
            return [String: Any]()
        
        default: return [String: Any]()
        }
    }

    var outOfSession: Bool {
        switch self {
        case .walkchainAccepted: return true
        case .appTerminate: return true
        default: return false
        }
    }
}

private extension AnalyticsEvents {
    // MARK: Helpers
    
    func offerAttributes(_ offer: Offer) -> [String: Any] {
        var params = [String: Any]()
        params["offer_id"] = offer.id
        params["price"] = offer.price
        params["offer_name"] = offer.title
        params["type"] = offer.type.description
        return params
    }
    
    func offerAttributes(_ offer: Offer, marketplace: String) -> [String: Any] {
        var params = offerAttributes(offer)
        params["marketplace"] = marketplace
        return params
    }
    
    func departureAttributes(_ visit: CLVisit) -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return ["longitude":  visit.coordinate.longitude, "latitude": visit.coordinate.latitude,
                "departure_date": dateFormatter.string(from: visit.departureDate),
                "arrival_date": dateFormatter.string(from: visit.arrivalDate)]
    }
    
    func walkchainAttributes(_ walkchain: Walkchain) -> [String: Any] {
        guard case let .accepted(earned, total, approved, converted) = walkchain.state
            else { return [String: Any]() }
        
        return ["total_steps": total, "converted_steps": converted,
            "outdoor_steps": approved, "sweatcoin_generated": String(format: "%.2f", earned)]
    }
    
}
