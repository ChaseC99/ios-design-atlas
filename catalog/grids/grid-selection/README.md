---
id: "grid-selection"
title: "Selectable artwork grids"
summary: "Selection overlays keep an image grid compact while supporting individual and batch actions."
category: "Grids"
family: "Grids"
order: 1003
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "GridSelectionDemo.swift"
view: "GridSelectionDemo"
captureNavigation: true
ownsNavigation: false
apis: ["LazyVGrid", "Button", "accessibilityAddTraits"]
tags: ["images", "selection", "batch", "overlay"]
---

# Selectable artwork grids

Selection overlays keep an image grid compact while supporting individual and batch actions.

## SwiftUI

```swift
import SwiftUI

struct SelectableGrid: View {
    @State private var selected: Set<Int> = []

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<12) { id in
                Button {
                    if !selected.insert(id).inserted { selected.remove(id) }
                } label: {
                    Image(systemName: selected.contains(id) ? "checkmark.circle.fill" : "leaf")
                        .frame(maxWidth: .infinity).frame(height: 100)
                        .background(.teal.opacity(0.1), in: .rect(cornerRadius: 12))
                }
                .accessibilityLabel("Artwork \(id + 1)")
                .accessibilityAddTraits(selected.contains(id) ? .isSelected : [])
            }
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Selectable artwork grids on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765909.169.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Selectable artwork grids on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765679.39.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](GridSelectionDemo.swift).

## Reference

[Apple: LazyVGrid](https://developer.apple.com/documentation/swiftui/lazyvgrid).
