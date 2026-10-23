---
id: "storekit-store-view"
title: "Native product collections"
summary: "StoreView lays out several real StoreKit products and their native purchase controls."
category: "Purchases"
family: "Purchases and subscriptions"
order: 3102
kind: "native"
demoMinIOS: "18.0"
swiftFile: "StoreKitStoreViewDemo.swift"
view: "StoreKitStoreViewDemo"
captureNavigation: true
ownsNavigation: false
captureStoreKit: true
apis: ["StoreView", "Product.products(for:)", "productViewStyle", "storeButton"]
tags: ["StoreKit", "store", "product collection", "localized prices"]
---

# Native product collections

StoreView lays out several real StoreKit products and their native purchase controls.

## SwiftUI

```swift
import SwiftUI
import StoreKit

struct NativeProductShelf: View {
    var body: some View {
        StoreView(ids: ["dev.iosdesignatlas.fixture.notes", "dev.iosdesignatlas.fixture.icons", "dev.iosdesignatlas.fixture.colors"]) { _ in
            Image(systemName: "sparkles").font(.title)
        }
        .productViewStyle(.compact)
        .storeButton(.hidden, for: .cancellation)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Native product collections on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770074.889.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Native product collections on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792770515.638.png)
<!-- captures:end -->

## Example notes

All three products are fictional non-consumables supplied by the local fixture. Prices and product text are returned by StoreKit; the app supplies only the original symbol artwork. The full example requires all three products before exposing its loaded marker. Capture does not tap a product, restore, sign-in, or other account action.

## Local StoreKit setup

Use the shared [AtlasPurchases.storekit](../AtlasPurchases.storekit) fixture. See [integration and capture rules](../STOREKIT.md).


## Full example

[Open the complete runnable example](StoreKitStoreViewDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/storekit/storeview).
