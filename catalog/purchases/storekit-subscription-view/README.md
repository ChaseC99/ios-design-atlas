---
id: "storekit-subscription-view"
title: "Native subscription choices"
summary: "SubscriptionStoreView presents plan choices, billing details, introductory eligibility, and a native subscription action."
category: "Purchases"
family: "Purchases and subscriptions"
order: 3103
kind: "native"
demoMinIOS: "18.0"
swiftFile: "StoreKitSubscriptionViewDemo.swift"
view: "StoreKitSubscriptionViewDemo"
captureNavigation: false
ownsNavigation: false
captureStoreKit: true
apis: ["SubscriptionStoreView", "subscriptionStoreControlStyle", "subscriptionStoreButtonLabel", "storeButton"]
tags: ["StoreKit", "subscription", "trial", "plan selection", "billing period"]
---

# Native subscription choices

SubscriptionStoreView presents plan choices, billing details, introductory eligibility, and a native subscription action.

## SwiftUI

```swift
import SwiftUI
import StoreKit

struct NativeSubscriptionPlans: View {
    var body: some View {
        SubscriptionStoreView(productIDs: ["dev.iosdesignatlas.fixture.plus.monthly", "dev.iosdesignatlas.fixture.plus.yearly"]) {
            Text("Make room for every idea.").font(.title.bold())
        }
        .subscriptionStoreControlStyle(.prominentPicker)
        .subscriptionStoreButtonLabel(.multiline)
        .storeButton(.visible, for: .restorePurchases)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Native subscription choices on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770110.994.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Native subscription choices on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792770527.142.png)
<!-- captures:end -->

## Example notes

The local fixture defines monthly and yearly plans in one fictional subscription group. StoreKit supplies localized prices, billing periods, and introductory-offer eligibility. Trial messaging depends on the test session’s history and eligibility, not a hardcoded banner. Policy destinations explicitly describe this local example; they are not production legal documents. Capture never taps Subscribe or Restore Purchases.

## Local StoreKit setup

Use the shared [AtlasPurchases.storekit](../AtlasPurchases.storekit) fixture. See [integration and capture rules](../STOREKIT.md).


## Full example

[Open the complete runnable example](StoreKitSubscriptionViewDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/storekit/subscriptionstoreview).
