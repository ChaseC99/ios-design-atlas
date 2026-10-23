---
id: "purchase-management"
title: "Purchase status and management"
summary: "Verified entitlements drive access status while explicit actions expose restoration and native subscription management."
category: "Purchases"
family: "Purchases and subscriptions"
order: 3104
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PurchaseManagementDemo.swift"
view: "PurchaseManagementDemo"
captureNavigation: true
ownsNavigation: false
captureStoreKit: true
apis: ["Transaction.currentEntitlements", "Product.SubscriptionInfo.status", "AppStore.sync", "manageSubscriptionsSheet", "offerCodeRedemption"]
tags: ["restore purchases", "entitlements", "subscription management", "offer redemption", "verification"]
---

# Purchase status and management

Verified entitlements drive access status while explicit actions expose restoration and native subscription management.

## SwiftUI

```swift
import SwiftUI
import StoreKit

struct RestoreAndManagePurchases: View {
    @State private var manage = false
    @State private var message = ""
    var body: some View {
        VStack {
            Button("Restore purchases") {
                Task {
                    do { try await AppStore.sync(); message = "Refresh verified entitlements now." }
                    catch { message = error.localizedDescription }
                }
            }
            Button("Manage subscriptions") { manage = true }
            Text(message)
        }
        .manageSubscriptionsSheet(isPresented: $manage, subscriptionGroupID: "31000001")
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

The initial capture is an actual empty local entitlement state. Only verified transactions matching the fixture IDs grant access; subscription status is read from StoreKit. Restore, management, and offer redemption are explicit native affordances and are never activated during capture. The iOS 27 offer-redemption overload is availability guarded. Existing-subscriber and billing-retry captures need a separately authorized local transaction test; this example does not manufacture them.

## Local StoreKit setup

Use the shared [AtlasPurchases.storekit](../AtlasPurchases.storekit) fixture. See [integration and capture rules](../STOREKIT.md).


## Full example

[Open the complete runnable example](PurchaseManagementDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/storekit/transaction/currententitlements).
