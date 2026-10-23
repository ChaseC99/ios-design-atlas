---
id: "numbers-dates-timers"
title: "Numbers, dates, and timers"
summary: "Stable digits and formatting that follows the locale."
category: "Typography"
family: "Formatting"
order: 1507
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NumbersDatesTimersDemo.swift"
view: "NumbersDatesTimersDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["monospacedDigit", "Date.FormatStyle", "contentTransition"]
tags: ["numeric text", "relative dates", "timer"]
---

# Numbers, dates, and timers

Monospaced digits keep changing numbers steady, while native date and duration formats adapt to locale and context.

## SwiftUI

```swift
import SwiftUI

struct StableCounter: View {
    @State private var count = 48
    var body: some View {
        VStack(spacing: 24) {
            Text(count, format: .number)
                .font(.system(size: 64, weight: .light))
                .monospacedDigit().contentTransition(.numericText())
            Button("Add one") { withAnimation { count += 1 } }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NumbersDatesTimersDemo.swift).

## Reference

[Apple: monospacedDigit](https://developer.apple.com/documentation/swiftui/view/monospaceddigit()).
