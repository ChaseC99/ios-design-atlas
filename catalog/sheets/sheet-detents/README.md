---
id: "sheet-detents"
title: "Sheet detents"
summary: "Give a sheet a few useful resting heights."
category: "Sheets"
family: "Sizing"
order: 102
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetDetentsDemo.swift"
view: "SheetDetentsDemo"
apis: ["presentationDetents", "PresentationDetent", "CustomPresentationDetent"]
tags: ["medium", "large", "fraction", "height", "selection"]
captureNavigation: false
captureStyle: "screen"
---

# Sheet detents

Detents define the heights at which a sheet can rest. Use medium, large, fixed, fractional, or custom heights, and bind the selected detent when an action should expand or collapse the sheet.

## SwiftUI

```swift
import SwiftUI

struct DetentsRecipe: View {
    @State private var isPresented = false
    @State private var selected: PresentationDetent = .medium

    var body: some View {
        Button("Show route") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                Button("Expand route") { selected = .large }
                    .presentationDetents([.medium, .large], selection: $selected)
                    .presentationDragIndicator(.visible)
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetDetentsDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
