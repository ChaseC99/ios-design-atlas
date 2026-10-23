---
id: "sheet-navigation"
title: "Navigation and nested sheets"
summary: "Keep a small flow together inside its presentation."
category: "Sheets"
family: "Flows"
order: 109
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetNavigationDemo.swift"
view: "SheetNavigationDemo"
apis: ["NavigationStack", "NavigationLink", "sheet", "dismiss"]
tags: ["navigation", "nested", "flow"]
captureNavigation: false
captureStyle: "screen"
---

# Navigation and nested sheets

A navigation stack inside a sheet gives a modal task its own history and toolbar. A second sheet can present a supporting choice from that flow; attach it to the already-presented content so the first sheet remains underneath.

## SwiftUI

```swift
import SwiftUI

struct NestedSheetRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Edit collection") { isPresented = true }
            .sheet(isPresented: $isPresented) { CollectionEditorRecipe() }
    }
}

private struct CollectionEditorRecipe: View {
    @State private var choosesColor = false

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Details") { Text("Collection details") }
                Button("Choose color") { choosesColor = true }
            }
            .navigationTitle("Collection")
            .sheet(isPresented: $choosesColor) {
                Button("Use green") { choosesColor = false }
                    .presentationDetents([.medium])
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

[Open the complete runnable example](SheetNavigationDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
