---
id: "popover-content"
title: "Content inside popovers"
summary: "Lists, forms, and a small navigation stack."
category: "Presentation"
family: "Popovers"
order: 6
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverContentDemo.swift"
view: "PopoverContentDemo"
apis: ["popover", "NavigationStack", "List", "Form"]
tags: ["navigation", "editing", "containers"]
captureNavigation: false
captureStyle: "screen"
---

# Content inside popovers

A popover can contain a navigation stack, a list, or a form while keeping the interaction connected to its source.

## SwiftUI

```swift
import SwiftUI

struct CollectionPopover: View {
    @State private var showing = false
    var body: some View {
        Button("Collections") { showing = true }
            .popover(isPresented: $showing) {
                NavigationStack {
                    List(["Personal", "Work"], id: \.self) { name in
                        NavigationLink(name) { Text(name) }
                    }
                    .navigationTitle("Collections")
                }
                .frame(width: 320, height: 380)
                .presentationCompactAdaptation(.popover)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Content inside popovers on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762873.697.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PopoverContentDemo.swift).
