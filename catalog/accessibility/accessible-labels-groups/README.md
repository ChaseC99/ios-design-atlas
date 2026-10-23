---
id: "accessible-labels-groups"
title: "Labels and logical groups"
summary: "Accessible labels and groups turn a visual arrangement into a concise, meaningful reading order."
category: "Accessibility"
family: "Semantics"
order: 2002
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AccessibleLabelsGroupsDemo.swift"
view: "AccessibleLabelsGroupsDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "The default capture uses the system Large text setting. Preview controls affect only this example."
apis: ["accessibilityElement", "accessibilityLabel", "accessibilityValue", "accessibilitySortPriority"]
tags: ["VoiceOver", "grouping", "decorative image", "reading order"]
---

# Labels and logical groups

Accessible labels and groups turn a visual arrangement into a concise, meaningful reading order.

## SwiftUI

```swift
import SwiftUI

struct AccessibleBookSummary: View {
    var body: some View {
        HStack {
            Image(systemName: "book.closed").accessibilityHidden(true)
            VStack(alignment: .leading) {
                Text("After the city sleeps")
                Text("8 min read").foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("After the city sleeps")
        .accessibilityValue("Eight minute read")
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Labels and logical groups on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765339.163.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Labels and logical groups on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765289.962.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Labels and logical groups on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767508.92.png)
<!-- captures:end -->

## Verification

The default capture uses the system Large text setting. Preview controls affect only this example. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](AccessibleLabelsGroupsDemo.swift).

## Reference

[Apple: accessibilityElement](https://developer.apple.com/documentation/swiftui/accessible-descriptions).
