---
id: "system-materials"
title: "System materials"
summary: "Five translucent surfaces over the same artwork."
category: "Materials"
family: "Materials"
order: 801
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SystemMaterialsDemo.swift"
view: "SystemMaterialsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["Material", "background"]
tags: ["blur", "translucency", "thickness"]
---

# System materials

System materials blend and blur the content behind a surface while adapting their appearance to the environment.

## SwiftUI

```swift
import SwiftUI

struct MaterialCard: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .teal],
                           startPoint: .top, endPoint: .bottom)
            Label("Saved places", systemImage: "bookmark")
                .font(.title2).padding(28)
                .background(.regularMaterial,
                            in: RoundedRectangle(cornerRadius: 24))
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![System materials on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763085.526.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![System materials on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766863.419.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![System materials on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766562.767.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SystemMaterialsDemo.swift).

## Reference

[Apple: Material](https://developer.apple.com/documentation/swiftui/material).
