---
id: "day-plan-timeline"
title: "A day-plan timeline"
summary: "Connect scheduled events with a continuous visual rhythm."
category: "Custom patterns"
family: "Information patterns"
order: 3406
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "DayPlanTimelineDemo.swift"
view: "DayPlanTimelineDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["VStack", "fixedSize", "Button"]
tags: ["custom", "timeline", "schedule"]
---

# A day-plan timeline

A custom timeline connects events and expands the selected stop. A sectioned `List` is the native alternative when simple chronological rows are enough.

## SwiftUI

```swift
import SwiftUI

struct SimpleTimeline: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                HStack(alignment: .top, spacing: 16) {
                    VStack(spacing: 0) {
                        Circle().fill(.teal).frame(width: 14, height: 14)
                        Rectangle().fill(.teal.opacity(0.2)).frame(width: 2)
                    }.frame(width: 20)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Stop \(index + 1)").font(.headline)
                        Text("A little room in the day.").foregroundStyle(.secondary)
                    }.padding(.bottom, 28)
                    Spacer()
                }.fixedSize(horizontal: false, vertical: true)
            }
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![A day-plan timeline on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770594.881.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](DayPlanTimelineDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/list).
