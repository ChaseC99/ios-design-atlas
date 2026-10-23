---
id: "plain-button-hit-area"
title: "One modifier, a larger hit area"
summary: "Include the empty space inside a custom plain button."
category: "Custom patterns"
family: "Community discoveries"
order: 3410
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "PlainButtonHitAreaDemo.swift"
view: "PlainButtonHitAreaDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["contentShape", "buttonStyle(.plain)", "Button"]
tags: ["custom", "Sarun", "hit testing", "single modifier"]
---

# One modifier, a larger hit area

An original before-and-after study inspired by Sarun’s [SwiftUI Plain Button Style cannot tap on an Empty space](https://sarunw.com/posts/swiftui-plain-button-style-cannot-tap/) (26 June 2023). `contentShape` defines the custom label’s hit region; keep a native Button so activation and accessibility semantics remain intact.

## SwiftUI

```swift
import SwiftUI

struct TappableCardRow: View {
    @State private var selected = false
    var body: some View {
        Button { selected.toggle() } label: {
            HStack {
                Label("Save this idea", systemImage: "bookmark")
                Spacer(minLength: 60)
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
            }
            .padding(24)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(.teal.opacity(0.08), in: .rect(cornerRadius: 22))
        .accessibilityValue(selected ? "Saved" : "Not saved")
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](PlainButtonHitAreaDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/view/contentshape(_:eofill:)).
