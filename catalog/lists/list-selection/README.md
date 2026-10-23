---
id: "list-selection"
title: "List selection"
summary: "Native list selection supports one item or a set of items for batch actions."
category: "Lists"
family: "Selection"
order: 903
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListSelectionDemo.swift"
view: "ListSelectionDemo"
captureNavigation: true
ownsNavigation: false
apis: ["List(selection:)", "EditMode", "toolbar"]
tags: ["single selection", "multiple selection", "batch actions"]
---

# List selection

Native list selection supports one item or a set of items for batch actions.

## SwiftUI

```swift
import SwiftUI

struct SelectableNotes: View {
    @State private var selected: Set<String> = []
    private let notes = ["Quiet mornings", "Open water", "The long way home"]

    var body: some View {
        List(notes, id: \.self, selection: $selected) { note in
            Text(note).tag(note)
        }
        .environment(\.editMode, .constant(.active))
        .safeAreaInset(edge: .bottom) {
            Text("\(selected.count) selected").padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![List selection on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766073.999.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![List selection on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765873.529.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![List selection on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768070.898.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListSelectionDemo.swift).

## Reference

[Apple: List(selection:)](https://developer.apple.com/documentation/swiftui/list).
