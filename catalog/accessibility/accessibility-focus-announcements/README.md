---
id: "accessibility-focus-announcements"
title: "Presentation focus and announcements"
summary: "Accessibility focus can move to a newly presented heading, and a brief announcement can confirm an action."
category: "Accessibility"
family: "Semantics"
order: 2005
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AccessibilityFocusAnnouncementsDemo.swift"
view: "AccessibilityFocusAnnouncementsDemo"
captureNavigation: false
ownsNavigation: false
captureEnvironmentNotes: "Capture shows a real sheet. Accessibility focus and spoken announcements require manual assistive-technology checks."
apis: ["AccessibilityFocusState", "accessibilityFocused", "AccessibilityNotification"]
tags: ["modal focus", "announcement", "VoiceOver", "save"]
---

# Presentation focus and announcements

Accessibility focus can move to a newly presented heading, and a brief announcement can confirm an action.

## SwiftUI

```swift
import SwiftUI
import Accessibility

struct SaveAnnouncement: View {
    @State private var saved = false

    var body: some View {
        Button(saved ? "Saved" : "Save collection") {
            saved = true
            AccessibilityNotification.Announcement("Collection saved").post()
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Verification

Capture shows a real sheet. Accessibility focus and spoken announcements require manual assistive-technology checks. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](AccessibilityFocusAnnouncementsDemo.swift).

## Reference

[Apple: AccessibilityFocusState](https://developer.apple.com/documentation/swiftui/accessibilityfocusstate).
