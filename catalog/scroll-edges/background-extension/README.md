---
id: "background-extension"
title: "Background extension"
summary: "Extend a hero\u2019s colors beneath neighboring interface elements."
category: "Scroll edges"
family: "Backgrounds"
order: 708
kind: "native"
demoMinIOS: "26.0"
swiftFile: "BackgroundExtensionDemo.swift"
view: "BackgroundExtensionDemo"
captureNavigation: false
ownsNavigation: true
captureStyle: "screen"
apis: ["backgroundExtensionEffect", "NavigationSplitView"]
tags: ["sidebar", "hero", "immersive"]
---

# Background extension

Background extension mirrors and blurs the edges of a view into available safe areas, including space beneath a split-view sidebar.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct ExtendedHero: View {
    var body: some View {
        NavigationSplitView {
            List { Text("Coast"); Text("Forest") }
        } detail: {
            LinearGradient(colors: [.indigo, .teal],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .backgroundExtensionEffect()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Background extension on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762654.256.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Background extension on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765353.98.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](BackgroundExtensionDemo.swift).

## Reference

[Apple: backgroundExtensionEffect](https://developer.apple.com/documentation/swiftui/view/backgroundextensioneffect()).
