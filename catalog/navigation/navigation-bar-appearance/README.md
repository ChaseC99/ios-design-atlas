---
id: "navigation-bar-appearance"
title: "Navigation bar appearance"
summary: "Backgrounds, visibility, and color schemes change how content meets a navigation bar."
category: "Navigation"
family: "Bars"
order: 305
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationBarAppearanceDemo.swift"
view: "NavigationBarAppearanceDemo"
captureNavigation: false
ownsNavigation: true
apis: ["toolbarBackground", "toolbarColorScheme", "toolbar"]
tags: ["tint", "visibility", "background"]
---

# Navigation bar appearance

Backgrounds, visibility, and color schemes change how content meets a navigation bar.

## SwiftUI

```swift
import SwiftUI

struct ColoredNavigationBar: View {
    var body: some View {
        NavigationStack {
            List(["On noticing", "Everyday rituals"], id: \.self) {
                Text($0)
            }
            .navigationTitle("Reading")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Navigation bar appearance on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766190.63.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Navigation bar appearance on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766006.937.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationBarAppearanceDemo.swift).

## Reference

[Apple: toolbarBackground](https://developer.apple.com/documentation/swiftui/toolbars).
