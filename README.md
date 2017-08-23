# Analytics

Setup

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AnalyticsManager.providers.append(FirebaseAnalyticsManager())
        AnalyticsManager.providers.append(FacebookAnalyticsManager())
        AnalyticsManager.providers.append(LogAnalyticsManager())
        AnalyticsManager.providers.append(AmplitudeAnalyticsManager(apiKey: amplitudeKey))
        
        manager.providers.forEach { $0.app(application, launchedWithOptions: options) }
       
        return true
    }
```

How to use:

```swift
AnalyticsManager.log(event: .sendFeedbackSuccess) // simple event
AnalyticsManager.log(event: .findFriendsInvite(action: action, source: source)) // event with params, type safe!
AnalyticsManager.log(event: .leaderboardConsoleWillConnectPhonebook)
AnalyticsManager.log(event: .leaderboardConsoleDidConnectPhonebook(contacts: follow.count))
```
