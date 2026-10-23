---
id: "widget-families"
title: "Widget families"
summary: "A widget adapts the same timeline entry to Home Screen and Lock Screen families."
category: "System surfaces"
family: "Widgets and activities"
order: 3201
kind: "native"
demoMinIOS: "18.0"
swiftFile: "WidgetFamiliesDemo.swift"
view: "WidgetFamiliesDemo"
apis: ["Widget", "StaticConfiguration", "TimelineProvider", "widgetFamily"]
tags: ["widgetkit", "system", "outside-app"]
captureNavigation: true
captureManual: true
captureManualReason: "Record the installed widget on the Home Screen and Lock Screen. In-app previews do not establish widget margins, tint rendering, privacy redaction, timeline refresh, or system-family layout."
---

# Widget families

A widget adapts the same timeline entry to Home Screen and Lock Screen families. The full example switches its content using `widgetFamily` and leaves margins and rendering to WidgetKit; its static local fixture uses a `.never` timeline policy because it has no changing data.

## SwiftUI

```swift
import SwiftUI
import WidgetKit

struct ReadingEntry: TimelineEntry { let date: Date; let pages: Int }
struct ReadingProvider: TimelineProvider {
    func placeholder(in context: Context) -> ReadingEntry { ReadingEntry(date: .now, pages: 32) }
    func getSnapshot(in context: Context, completion: @escaping (ReadingEntry) -> Void) { completion(placeholder(in: context)) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<ReadingEntry>) -> Void) {
        completion(Timeline(entries: [placeholder(in: context)], policy: .never))
    }
}
struct ReadingWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Reading", provider: ReadingProvider()) { entry in
            Text("\(entry.pages) pages").containerBackground(.background, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Reading")
        .description("A local reading snapshot.")
    }
}
```

## Captures

<!-- captures:start -->
Native system-surface captures are pending. The in-app view is a content preview.
<!-- captures:end -->

## Full example

[Open the complete runnable example](WidgetFamiliesDemo.swift). The same source is compiled by the AtlasWidgets extension.

Record the installed widget on the Home Screen and Lock Screen. In-app previews do not establish widget margins, tint rendering, privacy redaction, timeline refresh, or system-family layout.

## References

[Apple: WidgetKit](https://developer.apple.com/documentation/widgetkit).
