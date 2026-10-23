---
id: "navigation-title-menu"
title: "Title menus and subtitles"
summary: "A title menu keeps document actions next to the document name."
category: "Navigation"
family: "Titles"
order: 303
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationTitleMenuDemo.swift"
view: "NavigationTitleMenuDemo"
captureNavigation: false
ownsNavigation: true
apis: ["toolbarTitleMenu", "navigationTitle", "navigationSubtitle"]
tags: ["document", "rename", "subtitle"]
---

# Title menus and subtitles

A title menu keeps document actions next to the document name.

## SwiftUI

```swift
import SwiftUI

struct DocumentTitleMenu: View {
    @State private var title = "Weekend plans"
    @State private var favorite = false

    var body: some View {
        NavigationStack {
            Text("A little room to wander.")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarTitleMenu {
                    Button(favorite ? "Unfavorite" : "Favorite",
                           systemImage: "star") {
                        favorite.toggle()
                    }
                }
        }
    }
}
```

The complete example adds the native subtitle on iOS 26 and later.

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationTitleMenuDemo.swift).

## Reference

[Apple: toolbarTitleMenu](https://developer.apple.com/documentation/swiftui/view/toolbartitlemenu(content:)).
