---
id: "sheet-adaptation"
title: "Compact sheet adaptation"
summary: "Let a presentation respond to the available room."
category: "Sheets"
family: "Adaptation"
order: 112
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetAdaptationDemo.swift"
view: "SheetAdaptationDemo"
apis: ["presentationCompactAdaptation", "presentationSizing", "horizontalSizeClass", "verticalSizeClass"]
tags: ["compact", "regular", "landscape", "ipad"]
captureNavigation: false
captureStyle: "screen"
---

# Compact sheet adaptation

Sheets adapt as horizontal and vertical space changes. A compact adaptation preference lets you compare the system default with a sheet or full-screen treatment; rotate an iPhone or resize an iPad window to see where the policy takes effect.

## SwiftUI

```swift
import SwiftUI

struct SheetAdaptationRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show packing list") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                List(["Notebook", "Water bottle", "Light jacket"], id: \.self) {
                    Text($0)
                }
                .presentationSizing(.form)
                .presentationCompactAdaptation(.sheet)
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetAdaptationDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
