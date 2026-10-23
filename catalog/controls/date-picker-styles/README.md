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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Date and time pickers on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765576.718.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Date and time pickers on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765499.188.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Date and time pickers on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767732.268.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](DatePickerStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).
