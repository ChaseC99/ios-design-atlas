---
id: "sheet-basics"
title: "Default sheets"
summary: "A focused task above the current screen."
category: "Sheets"
family: "Sizing"
order: 101
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetBasicsDemo.swift"
view: "SheetBasicsDemo"
apis: ["sheet", "presentationSizing", "dismiss"]
tags: ["default", "form", "page", "adaptation"]
captureNavigation: false
captureStyle: "screen"
---

# Default sheets

A sheet presents a focused task above the current interface. Its default size and placement adapt to the available space; form and page sizing let you express the kind of content it contains.

## SwiftUI

```swift
import SwiftUI

struct DefaultSheetRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("New collection") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    Form {
                        Text("A place for your next idea.")
                    }
                    .navigationTitle("New collection")
                    .toolbar {
                        Button("Done") { isPresented = false }
                    }
                }
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetBasicsDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
