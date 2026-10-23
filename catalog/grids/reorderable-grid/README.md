---
id: "reorderable-grid"
title: "Reorderable grids"
summary: "Drag-and-drop destinations can move items within a custom grid while preserving their identity."
category: "Grids"
family: "Grids"
order: 1006
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ReorderableGridDemo.swift"
view: "ReorderableGridDemo"
captureNavigation: true
ownsNavigation: false
apis: ["draggable", "dropDestination", "LazyVGrid", "accessibilityAction"]
tags: ["drag", "drop", "reorder", "accessibility"]
---

# Reorderable grids

Drag-and-drop destinations can move items within a custom grid while preserving their identity.

## SwiftUI

```swift
import SwiftUI

struct DragReorderingGrid: View {
    @State private var items = ["Sun", "Moon", "Water", "Leaf"]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(items, id: \.self) { item in
                Text(item).frame(maxWidth: .infinity).frame(height: 100)
                    .background(.indigo.opacity(0.1), in: .rect(cornerRadius: 16))
                    .draggable(item)
                    .dropDestination(for: String.self) { values, _ in
                        guard let value = values.first,
                              let source = items.firstIndex(of: value),
                              let destination = items.firstIndex(of: item),
                              source != destination else { return false }
                        withAnimation {
                            items.move(fromOffsets: IndexSet(integer: source), toOffset: source < destination ? destination + 1 : destination)
                        }
                        return true
                    }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Reorderable grids on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766210.211.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Reorderable grids on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792769113.437.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ReorderableGridDemo.swift).

## Reference

[Apple: dropDestination](https://developer.apple.com/documentation/swiftui/view/dropdestination(for:action:istargeted:)).
