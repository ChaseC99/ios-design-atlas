---
id: "accessible-data-summaries"
title: "Accessible data and image summaries"
summary: "Meaningful text descriptions complement visual information without forcing a person to interpret color or shape."
category: "Accessibility"
family: "Semantics"
order: 2009
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AccessibleDataSummariesDemo.swift"
view: "AccessibleDataSummariesDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "The default capture uses the system Large text setting. Preview controls affect only this example."
apis: ["Chart", "accessibilityLabel", "accessibilityValue", "accessibilityHidden"]
tags: ["charts", "images", "summary", "VoiceOver"]
---

# Accessible data and image summaries

Meaningful text descriptions complement visual information without forcing a person to interpret color or shape.

## SwiftUI

```swift
import SwiftUI
import Charts

struct DescribedChart: View {
    private let minutes = ["Mon": 25, "Tue": 40, "Wed": 30]

    var body: some View {
        VStack(alignment: .leading) {
            Chart(["Mon", "Tue", "Wed"], id: \.self) { day in
                BarMark(x: .value("Day", day), y: .value("Minutes", minutes[day] ?? 0))
                    .accessibilityLabel(day)
                    .accessibilityValue("\(minutes[day] ?? 0) minutes outdoors")
            }
            Text("Tuesday had the most time outdoors: 40 minutes.")
        }
        .frame(height: 240)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Accessible data and image summaries on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765319.955.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Accessible data and image summaries on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765268.176.png)
<!-- captures:end -->

## Verification

The default capture uses the system Large text setting. Preview controls affect only this example. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](AccessibleDataSummariesDemo.swift).

## Reference

[Apple: Chart](https://developer.apple.com/documentation/charts).
