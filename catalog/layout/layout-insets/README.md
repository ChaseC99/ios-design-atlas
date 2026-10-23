---
id: "layout-insets"
title: "Padding, margins, and safe areas"
summary: "Leave room for content and persistent actions."
category: "Layout"
family: "Insets"
order: 1703
kind: "native"
demoMinIOS: "18.0"
swiftFile: "LayoutInsetsDemo.swift"
view: "LayoutInsetsDemo"
apis: ["padding", "contentMargins", "safeAreaInset", "ignoresSafeArea"]
tags: ["margins", "safe-area", "persistent-action", "scrolling"]
captureNavigation: true
captureStyle: "screen"
---

# Padding, margins, and safe areas

Padding belongs to a view, content margins belong to a scroll container, and safe-area insets reserve room for surrounding interface. Combining them lets content scroll comfortably above a persistent action without hiding its final items.

## SwiftUI

```swift
import SwiftUI

struct SafeAreaLayoutRecipe: View {

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(1...8, id: \.self) { Text("Field note \($0)").frame(maxWidth: .infinity).padding(24) }
            }
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)
        .safeAreaInset(edge: .bottom) {
            Text("8 saved notes").padding().frame(maxWidth: .infinity).background(.regularMaterial)
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](LayoutInsetsDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).
