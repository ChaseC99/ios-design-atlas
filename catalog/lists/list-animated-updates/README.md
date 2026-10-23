---
id: "list-animated-updates"
title: "Animated list updates"
summary: "Stable row identities let a list animate insertions, removals, and content changes."
category: "Lists"
family: "Updates"
order: 908
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListAnimatedUpdatesDemo.swift"
view: "ListAnimatedUpdatesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["withAnimation", "Identifiable", "ContentUnavailableView"]
tags: ["insert", "remove", "empty", "conditional", "variable height"]
---

# Animated list updates

Stable row identities let a list animate insertions, removals, and content changes.

## SwiftUI

```swift
import SwiftUI

struct AnimatedNotes: View {
    struct Note: Identifiable { let id = UUID(); let title: String }
    @State private var notes = [Note(title: "A quieter morning")]

    var body: some View {
        List {
            Button("Add note") {
                withAnimation { notes.insert(Note(title: "A new beginning"), at: 0) }
            }
            ForEach(notes) { Text($0.title) }
                .onDelete { offsets in
                    withAnimation { notes.remove(atOffsets: offsets) }
                }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListAnimatedUpdatesDemo.swift).

## Reference

[Apple: withAnimation](https://developer.apple.com/documentation/swiftui/list).
