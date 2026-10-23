---
id: "sheet-full-screen"
title: "From sheet to full screen"
summary: "Give a focused task more room when it needs it."
category: "Sheets"
family: "Flows"
order: 110
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetFullScreenDemo.swift"
view: "SheetFullScreenDemo"
apis: ["sheet", "fullScreenCover", "onDismiss"]
tags: ["full-screen", "handoff", "dismissal"]
captureNavigation: false
captureStyle: "screen"
---

# From sheet to full screen

A full-screen cover presents a task across the available screen. To move from a sheet into that space, dismiss the sheet first and present the cover from its dismissal callback, giving the system one presentation transition at a time.

## SwiftUI

```swift
import SwiftUI

struct FullScreenHandoffRecipe: View {
    @State private var showsSheet = false
    @State private var showsCover = false
    @State private var expandsAfterDismissal = false

    var body: some View {
        Button("Preview") { showsSheet = true }
            .sheet(isPresented: $showsSheet, onDismiss: {
                if expandsAfterDismissal {
                    expandsAfterDismissal = false
                    showsCover = true
                }
            }) {
                Button("Open full screen") {
                    expandsAfterDismissal = true
                    showsSheet = false
                }
            }
            .fullScreenCover(isPresented: $showsCover) {
                Button("Done") { showsCover = false }
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetFullScreenDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
