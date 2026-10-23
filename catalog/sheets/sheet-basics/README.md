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
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Default sheets on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762436.523.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Default sheets on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762982.06.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Default sheets on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792769137.537.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetBasicsDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
