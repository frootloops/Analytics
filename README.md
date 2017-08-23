# Analytics

Setup

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if !ConfigManager.enableAnalytics {
            return true
        }
        
        let amplitudeKey = ConfigManager.amplitudeKey
        let options = launchOptions ?? [UIApplicationLaunchOptionsKey: Any]()
        
        manager.providers.append(FirebaseAnalyticsManager())
        manager.providers.append(FacebookAnalyticsManager())
        manager.providers.append(LogAnalyticsManager())
        manager.providers.append(AmplitudeAnalyticsManager(apiKey: amplitudeKey))
        
        manager.providers.forEach { $0.app(application, launchedWithOptions: options) }
       
        return true
    }
```

How to use:

```swift
AnalyticsManager.log(event: .sendFeedbackSuccess)
AnalyticsManager.log(event: .findFriendsInvite(action: action, source: source))
AnalyticsManager.log(event: .leaderboardConsoleWillConnectPhonebook)
AnalyticsManager.log(event: .leaderboardConsoleDidConnectPhonebook(contacts: follow.count))
```
