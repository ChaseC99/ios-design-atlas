---
id: "settings-form"
title: "Settings forms"
summary: "Grouped settings expose preferences and reveal dependent options only when they apply."
category: "Forms"
family: "Forms"
order: 2501
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SettingsFormDemo.swift"
view: "SettingsFormDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Form", "Section", "Toggle", "Picker", "DatePicker"]
tags: ["settings", "dependent fields", "notifications"]
---

# Settings forms

Grouped settings expose preferences and reveal dependent options only when they apply.

## SwiftUI

```swift
import SwiftUI

struct DependentSettings: View {
    @State private var reminders = true
    @State private var frequency = "Weekly"

    var body: some View {
        Form {
            Section("Reminders") {
                Toggle("Enable reminders", isOn: $reminders)
                if reminders {
                    Picker("Summary", selection: $frequency) {
                        Text("Daily").tag("Daily")
                        Text("Weekly").tag("Weekly")
                    }
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

![Settings forms on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792771021.081.png)
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](SettingsFormDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).
