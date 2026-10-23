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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Animated list updates on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766035.313.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Animated list updates on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765804.37.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Animated list updates on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768026.212.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListAnimatedUpdatesDemo.swift).

## Reference

[Apple: withAnimation](https://developer.apple.com/documentation/swiftui/list).
