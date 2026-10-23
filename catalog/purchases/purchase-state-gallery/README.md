---
id: "purchase-state-gallery"
title: "App purchase and access states"
summary: "Explicit app-level states distinguish progress, cancellation, approval, errors, and access without imitating a system payment sheet."
category: "Purchases"
family: "Purchases and subscriptions"
order: 3106
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "PurchaseStateGalleryDemo.swift"
view: "PurchaseStateGalleryDemo"
captureNavigation: true
ownsNavigation: false
captureStoreKit: false
apis: ["ContentUnavailableView", "ProgressView", "Picker", "Button"]
tags: ["custom", "purchase states", "pending", "cancelled", "failed", "expired", "feature gating"]
---

# App purchase and access states

Explicit app-level states distinguish progress, cancellation, approval, errors, and access without imitating a system payment sheet.

## SwiftUI

```swift
import SwiftUI

struct PendingPurchaseFeedback: View {
    var body: some View {
        ContentUnavailableView("Waiting for approval", systemImage: "hourglass", description: Text("Keep exploring. Access changes only after a verified purchase arrives."))
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![App purchase and access states on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792769256.412.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![App purchase and access states on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792770340.254.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![App purchase and access states on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792770494.189.png)
<!-- captures:end -->

## Example notes

Every state in this gallery is an explicit local fixture. No StoreKit transaction, confirmation dialog, entitlement, or payment is simulated as authentic system UI. Controls only change app presentation. In production, drive these states from verified StoreKit results and transaction updates; cancellation and pending approval do not grant access.

## Full example

[Open the complete runnable example](PurchaseStateGalleryDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/storekit/product/purchaseresult).
