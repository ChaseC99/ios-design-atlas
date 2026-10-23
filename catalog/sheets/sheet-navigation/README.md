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
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Navigation and nested sheets on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762469.873.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Navigation and nested sheets on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763027.483.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Navigation and nested sheets on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792771048.935.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetNavigationDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
