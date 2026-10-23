---
id: "list-swipe-actions"
title: "Swipe actions"
summary: "Leading and trailing swipe actions put contextual commands on individual rows."
category: "Lists"
family: "Actions"
order: 904
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListSwipeActionsDemo.swift"
view: "ListSwipeActionsDemo"
captureNavigation: true
ownsNavigation: false
apis: ["swipeActions", "ButtonRole", "withAnimation"]
tags: ["leading", "trailing", "full swipe", "undo"]
---

# Swipe actions

Leading and trailing swipe actions put contextual commands on individual rows.

## SwiftUI

```swift
import SwiftUI

struct SwipeNotes: View {
    @State private var notes = ["The scenic route", "After the rain"]
    @State private var pinned: Set<String> = []

    var body: some View {
        List(notes, id: \.self) { note in
            Label(note, systemImage: pinned.contains(note) ? "pin.fill" : "note.text")
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") { pinned.insert(note) }
                        .tint(.orange)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        notes.removeAll { $0 == note }
                    }
                }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Swipe actions on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766096.039.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Swipe actions on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765895.407.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListSwipeActionsDemo.swift).

## Reference

[Apple: swipeActions](https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)).
