---
id: "right-to-left-layout"
title: "Right-to-left layouts"
summary: "Semantic leading and trailing alignment lets a native interface mirror for right-to-left languages."
category: "Localization"
family: "Language"
order: 2101
kind: "native"
demoMinIOS: "18.0"
swiftFile: "RightToLeftLayoutDemo.swift"
view: "RightToLeftLayoutDemo"
captureNavigation: false
ownsNavigation: true
captureEnvironmentNotes: "Capture uses Arabic fixture copy and local ar / rightToLeft environment overrides. Global device language and region remain unchanged."
apis: ["layoutDirection", "locale", "NavigationStack"]
tags: ["RTL", "Arabic", "mirroring", "navigation"]
---

# Right-to-left layouts

Semantic leading and trailing alignment lets a native interface mirror for right-to-left languages.

## SwiftUI

```swift
import SwiftUI

struct MirroredCollection: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    Text("طريق على الساحل")
                } label: {
                    Label("المشي على الساحل", systemImage: "water.waves")
                }
            }
            .navigationTitle("اكتشف")
        }
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.layoutDirection, .rightToLeft)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Right-to-left layouts on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766511.324.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Right-to-left layouts on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766247.463.png)
<!-- captures:end -->

## Locale notes

Capture uses Arabic fixture copy and local ar / rightToLeft environment overrides. Global device language and region remain unchanged.

## Full example

[Open the complete runnable example](RightToLeftLayoutDemo.swift).

## Reference

[Apple: layoutDirection](https://developer.apple.com/documentation/swiftui/layoutdirection).
