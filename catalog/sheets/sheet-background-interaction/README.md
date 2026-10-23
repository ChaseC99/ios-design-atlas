---
id: "sheet-background-interaction"
title: "Background interaction"
summary: "Keep the screen behind a small sheet useful."
category: "Sheets"
family: "Interaction"
order: 105
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetBackgroundInteractionDemo.swift"
view: "SheetBackgroundInteractionDemo"
apis: ["presentationBackgroundInteraction", "presentationDetents"]
tags: ["interaction", "detents", "background"]
captureNavigation: false
captureStyle: "screen"
---

# Background interaction

Background interaction controls whether the interface behind a sheet remains usable. Enabling it only through a low detent lets a small panel coexist with the main screen, then restores modal behavior when the panel expands.

## SwiftUI

```swift
import SwiftUI

struct BackgroundInteractionRecipe: View {
    @State private var isPresented = false
    @State private var count = 0

    var body: some View {
        VStack {
            Button("Saved: \(count)") { count += 1 }
            Button("Show panel") { isPresented = true }
        }
        .sheet(isPresented: $isPresented) {
            Text("Nearby places").font(.title2.bold()).padding()
                .presentationDetents([.height(220), .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(220)))
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetBackgroundInteractionDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).
