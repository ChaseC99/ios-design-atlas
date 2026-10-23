---
id: "search-placement-activation"
title: "Search placement and activation"
summary: "A native search field can remain visible in the navigation bar and activate through a binding."
category: "Search"
family: "Search fields"
order: 1401
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchPlacementActivationDemo.swift"
view: "SearchPlacementActivationDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: false
apis: ["searchable", "searchFocused", "SearchFieldPlacement"]
tags: ["placement", "activation", "focus", "cancel"]
---

# Search placement and activation

A native search field can remain visible in the navigation bar and activate through a binding.

## SwiftUI

```swift
import SwiftUI

struct SearchablePlaces: View {
    @State private var query = ""
    @State private var presented = false

    var body: some View {
        NavigationStack {
            List(["Big Sur", "Carmel"].filter {
                query.isEmpty || $0.localizedCaseInsensitiveContains(query)
            }, id: \.self) { Text($0) }
            .navigationTitle("Explore")
            .searchable(text: $query, isPresented: $presented,
                        placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Search placement and activation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766572.049.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Search placement and activation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766390.403.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Search placement and activation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768518.495.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchPlacementActivationDemo.swift).

## Reference

[Apple: searchable](https://developer.apple.com/documentation/swiftui/view/searchable(text:placement:prompt:)).
