---
id: "content-sized-sheets"
title: "Content-sized sheets"
summary: "Let a presentation fit the content inside it."
category: "Sheets"
family: "Sizing"
order: 103
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContentSizedSheetsDemo.swift"
view: "ContentSizedSheetsDemo"
apis: ["presentationSizing", "FittedPresentationSizing", "sticky"]
tags: ["content", "resizing", "intrinsic-size"]
captureNavigation: false
captureStyle: "screen"
---

# Content-sized sheets

Fitted presentation sizing asks the system to size a sheet around its content. A stable width keeps the layout calm while added details change the preferred height; the final geometry still depends on the device and available space.

## SwiftUI

```swift
import SwiftUI

struct FittedSheetRecipe: View {
    @State private var isPresented = false
    @State private var showsDetails = false

    var body: some View {
        Button("Show invitation") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Saturday by the sea").font(.title2.bold())
                    Toggle("Show details", isOn: $showsDetails)
                    if showsDetails { Text("Meet at the harbor at 9:00 AM.") }
                }
                .padding(28)
                .frame(idealWidth: 360)
                .presentationSizing(.fitted.sticky(horizontal: true))
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ContentSizedSheetsDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
