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
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Title menus and subtitles on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762837.642.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Title menus and subtitles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766241.085.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Title menus and subtitles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766050.586.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationTitleMenuDemo.swift).

## Reference

[Apple: toolbarTitleMenu](https://developer.apple.com/documentation/swiftui/view/toolbartitlemenu(content:)).
