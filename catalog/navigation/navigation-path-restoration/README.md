---
id: "navigation-path-restoration"
title: "Paths and restoration"
summary: "A typed path makes deep links and navigation restoration explicit."
category: "Navigation"
family: "Stacks"
order: 304
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationPathRestorationDemo.swift"
view: "NavigationPathRestorationDemo"
captureNavigation: false
ownsNavigation: true
apis: ["NavigationStack", "navigationDestination", "SceneStorage"]
tags: ["deep link", "state restoration", "path"]
---

# Paths and restoration

A typed path makes deep links and navigation restoration explicit.

## SwiftUI

```swift
import SwiftUI

struct RestorableNavigation: View {
    @SceneStorage("savedPath") private var savedPath = ""
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            Button("Open saved place") { path = ["Coast", "Point Reyes"] }
                .navigationDestination(for: String.self) { Text($0) }
        }
        .task {
            if let data = savedPath.data(using: .utf8) {
                path = (try? JSONDecoder().decode([String].self, from: data)) ?? []
            }
        }
        .onChange(of: path) { _, value in
            if let data = try? JSONEncoder().encode(value) {
                savedPath = String(decoding: data, as: UTF8.self)
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationPathRestorationDemo.swift).

## Reference

[Apple: NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack).
