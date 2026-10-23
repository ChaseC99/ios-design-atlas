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
<!-- captures:end -->

## Locale notes

Capture uses Arabic fixture copy and local ar / rightToLeft environment overrides. Global device language and region remain unchanged.

## Full example

[Open the complete runnable example](RightToLeftLayoutDemo.swift).

## Reference

[Apple: layoutDirection](https://developer.apple.com/documentation/swiftui/layoutdirection).
