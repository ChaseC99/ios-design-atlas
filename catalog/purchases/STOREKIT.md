# Local StoreKit fixture

`AtlasPurchases.storekit` contains fictional, local-only products. It is not synced to App Store Connect. Its version 3 configuration structure follows Apple's Backyard Birds sample; product names, IDs, descriptions, prices, and artwork are original atlas fixtures. The monthly subscription has a one-week free introductory offer. StoreKit decides eligibility from the local session history.

The five affected entry IDs and product IDs are listed in [fixture-manifest.json](fixture-manifest.json). `purchase-state-gallery` is explicitly custom app UI and does not use StoreKit.

## UI-test integration

`AtlasUITests` already bundles `AtlasPurchases.storekit`. When reusing the fixture in another target, include it in that UI-test bundle and verify the resource exists. Keep it out of the shipping app target. For filesystem-synchronized targets, confirm that the resulting test bundle actually contains the resource. No app entitlements, App Store Connect products, sandbox account, or real product IDs are required for this local fixture.

Retain a test session for the duration of each affected capture. The following helper belongs in the existing UI-test class, with `import StoreKitTest`, `import Foundation`, and `import XCTest`:

```swift
private var storeKitSession: SKTestSession?

private func configureLocalStoreKit() throws {
    guard let fixtureURL = Bundle(for: type(of: self)).url(
        forResource: "AtlasPurchases", withExtension: "storekit"
    ) else {
        throw NSError(domain: "AtlasStoreKitFixture", code: 1,
                      userInfo: [NSLocalizedDescriptionKey: "Missing local StoreKit fixture"])
    }
    let session = try SKTestSession(contentsOf: fixtureURL)
    session.resetToDefaultState()
    session.clearTransactions() // Only this local StoreKit test environment.
    session.locale = Locale(identifier: "en_US")
    session.storefront = "USA"
    session.timeRate = SKTestSession.TimeRate.realTime
    session.disableDialogs = false
    storeKitSession = session
}
```

Call `configureLocalStoreKit()` **before** `XCUIApplication.launch()` only for entries marked `captureStoreKit: true`. Retain the session until the app terminates. After launch, wait for the real `storekit-products-loaded` accessibility identifier before capturing. If it never appears, report fixture activation/product-loading failure and keep the setup/error state out of the comparison gallery.

Run these captures serially, outside other simulator matrix jobs. Apple documents one shared StoreKit testing environment; competing sessions can overwrite each other's settings. Clearing transactions above resets that local test history and supplies an eligible, never-purchased starting point. It does not change a real account. Do not seed transactions for the initial captures.

## Capture boundaries

Captures load metadata and read current entitlements. They **do not activate** purchase, restore, subscription-management, offer-redemption, sign-in, or account commands. Leave dialogs enabled so an unintended action cannot silently progress. No real or test transaction has been initiated as part of authoring these examples.

The management example exposes genuine native affordances, but its initial capture only shows empty verified local access. Existing-subscriber, pending approval, billing retry, restoration results, redemption, and purchase completion require separately planned local transaction tests. The custom gallery illustrates app feedback and access gating with a visible simulated-state label; it is not a StoreKit confirmation.

## Interactive Xcode run

For an interactive local run, select `AtlasPurchases.storekit` in **Edit Scheme → Run → Options → StoreKit Configuration**. This scheme setting is an alternative to the UI-test setup, not a reason to create App Store Connect products. Keep the scheme configuration local to the sample workflow. The atlas examples display an honest unavailable/setup state if their products cannot load.

Native ProductView, StoreView, SubscriptionStoreView, and custom-plan captures are verified on iOS 18.5 and 27.0. Revised purchase management is verified on iOS 27.0. iOS 26.5 SKTestSession fails to save/configure the local fixture with SKInternalErrorDomain Code=3; an isolated run and simulator restart did not resolve it. This is a test-session setup failure, not evidence of API incompatibility. No transactions have been initiated.

## Sources

- [Apple: Setting up StoreKit Testing in Xcode](https://developer.apple.com/documentation/xcode/setting-up-storekit-testing-in-xcode)
- [Apple: SKTestSession](https://developer.apple.com/documentation/storekittest/sktestsession)
- [Apple: SKTestSession.init(contentsOf:)](https://developer.apple.com/documentation/storekittest/sktestsession/init(contentsof:))
- [Apple: Backyard Birds sample](https://developer.apple.com/documentation/swiftui/backyard-birds-sample)
- [Apple: StoreKit sample](https://developer.apple.com/documentation/storekit/implementing-a-store-in-your-app-using-the-storekit-api)
