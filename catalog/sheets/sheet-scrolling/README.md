---
id: "sheet-scrolling"
title: "Scrolling and resizing"
summary: "Decide what an upward swipe does first."
category: "Sheets"
family: "Interaction"
order: 106
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetScrollingDemo.swift"
view: "SheetScrollingDemo"
apis: ["presentationContentInteraction", "presentationDetents"]
tags: ["scrolling", "resizing", "list", "gestures"]
captureNavigation: false
captureStyle: "screen"
---

# Scrolling and resizing

A sheet containing scrollable content can use a gesture to resize the presentation or move through its content. Presentation content interaction lets you prefer scrolling immediately or expanding the sheet before scrolling.

## SwiftUI

```swift
import SwiftUI

struct SheetScrollingRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show reading list") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                List(1...30, id: \.self) { Text("Field note \($0)") }
                    .presentationDetents([.medium, .large])
                    .presentationContentInteraction(.scrolls)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Scrolling and resizing on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762487.959.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Scrolling and resizing on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763036.96.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Scrolling and resizing on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766789.543.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetScrollingDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
