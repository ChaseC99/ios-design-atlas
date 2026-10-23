---
id: "navigation-title-styles"
title: "Navigation titles"
summary: "Large and inline titles establish the hierarchy of a destination."
category: "Navigation"
family: "Titles"
order: 302
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationTitleStylesDemo.swift"
view: "NavigationTitleStylesDemo"
captureNavigation: false
ownsNavigation: true
apis: ["navigationTitle", "navigationBarTitleDisplayMode", "ToolbarItem"]
tags: ["large title", "inline title", "truncation"]
---

# Navigation titles

Large and inline titles establish the hierarchy of a destination.

## SwiftUI

```swift
import SwiftUI

struct JournalTitles: View {
    var body: some View {
        NavigationStack {
            List(1...30, id: \.self) { index in
                NavigationLink("Journal entry \(index)") {
                    Text("A quieter afternoon.")
                        .navigationTitle("Entry \(index)")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Navigation titles on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762846.419.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Navigation titles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766251.81.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Navigation titles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766059.212.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationTitleStylesDemo.swift).

## Reference

[Apple: navigationTitle](https://developer.apple.com/documentation/swiftui/view/navigationbartitledisplaymode(_:)).
