---
id: "date-picker-styles"
title: "Date and time pickers"
summary: "Choose a moment in the right format."
category: "Controls"
family: "Dates"
order: 1204
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DatePickerStylesDemo.swift"
view: "DatePickerStylesDemo"
apis: ["DatePicker", "datePickerStyle", "locale", "timeZone"]
tags: ["compact", "wheel", "graphical", "date", "time", "localization"]
captureNavigation: true
captureStyle: "screen"
---

# Date and time pickers

A date picker uses the current calendar, locale, and time zone to present a date or time. Compact, wheel, and graphical styles offer different amounts of context, and the displayed components determine whether the task needs a date, a time, or both.

## SwiftUI

```swift
import SwiftUI

struct DatePickerRecipe: View {
    @State private var date = Date()
    var body: some View {
        DatePicker("Departure", selection: $date, displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(.compact)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](DatePickerStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).
