---
id: "system-text-styles"
title: "System text styles"
summary: "A native type scale that responds to Dynamic Type."
category: "Typography"
family: "Type scale"
order: 1501
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SystemTextStylesDemo.swift"
view: "SystemTextStylesDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Font.TextStyle", "font"]
tags: ["dynamic type", "headings", "body"]
---

# System text styles

Semantic text styles express hierarchy and resize with the user’s preferred text size.

## SwiftUI

```swift
import SwiftUI

struct SemanticType: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A quiet morning").font(.largeTitle)
            Text("A little room to think.").font(.headline)
            Text("Semantic styles adapt to Dynamic Type.").font(.body)
            Text("FIELD NOTES / 01").font(.caption)
                .foregroundStyle(.secondary)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![System text styles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766869.417.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![System text styles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766569.553.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![System text styles on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768723.171.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SystemTextStylesDemo.swift).

## Reference

[Apple: Font.TextStyle](https://developer.apple.com/documentation/swiftui/font/textstyle).
