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
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationBarAppearanceDemo.swift).

## Reference

[Apple: toolbarBackground](https://developer.apple.com/documentation/swiftui/toolbars).
