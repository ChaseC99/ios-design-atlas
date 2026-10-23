---
id: "date-selection"
title: "Date ranges and multiple dates"
summary: "Choose a stay or a few separate days."
category: "Controls"
family: "Dates"
order: 1205
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DateSelectionDemo.swift"
view: "DateSelectionDemo"
apis: ["DatePicker", "MultiDatePicker", "DateComponents"]
tags: ["range", "multiple-selection", "calendar"]
captureNavigation: true
captureStyle: "screen"
---

# Date ranges and multiple dates

A date range uses two related endpoints, while a multi-date picker selects separate calendar days. Constrain the end date to follow the start and store multiple selections as date components in the picker’s calendar.

## SwiftUI

```swift
import SwiftUI

struct MultipleDatesRecipe: View {
    @State private var dates: Set<DateComponents> = []
    var body: some View {
        MultiDatePicker("Available days", selection: $dates)
            .padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](DateSelectionDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).
