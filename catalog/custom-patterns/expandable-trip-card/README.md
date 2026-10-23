---
id: "expandable-trip-card"
title: "An expandable card"
summary: "Reveal the useful details inside a compact trip card."
category: "Custom patterns"
family: "Disclosure patterns"
order: 3401
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ExpandableTripCardDemo.swift"
view: "ExpandableTripCardDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Button", "withAnimation", "transition"]
tags: ["custom", "expandable", "disclosure"]
---

# An expandable card

A custom card reveals details without leaving its context. Use `DisclosureGroup` when a standard disclosure row fits the interface.

## SwiftUI

```swift
import SwiftUI

struct ExpandableCard: View {
    @State private var expanded = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                withAnimation(.snappy) { expanded.toggle() }
            } label: {
                HStack { Text("Trip details"); Spacer(); Image(systemName: expanded ? "chevron.up" : "chevron.down") }
                    .contentShape(Rectangle())
            }.buttonStyle(.plain).accessibilityValue(expanded ? "Expanded" : "Collapsed")
            if expanded { Text("Four stops along the coast.").transition(.opacity) }
        }.padding(24).background(.teal.opacity(0.1), in: .rect(cornerRadius: 24))
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ExpandableTripCardDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/disclosuregroup).
