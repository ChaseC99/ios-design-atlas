---
id: "international-script-input"
title: "International scripts and input"
summary: "System fonts and unrestricted text bindings accommodate different writing systems and ongoing text composition."
category: "Localization"
family: "Language"
order: 2106
kind: "native"
demoMinIOS: "18.0"
swiftFile: "InternationalScriptInputDemo.swift"
view: "InternationalScriptInputDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "Capture includes hand-authored Japanese, Arabic, Hindi, Korean, and Thai fixture strings with per-row locale/direction overrides. Keyboard language follows the person’s enabled keyboards; the app does not change it. Native-speaker review and IME/dictation input checks remain pending."
apis: ["TextField", "locale", "textInputAutocapitalization", "lineLimit"]
tags: ["Arabic", "Japanese", "Hindi", "Korean", "Thai", "IME"]
---

# International scripts and input

System fonts and unrestricted text bindings accommodate different writing systems and ongoing text composition.

## SwiftUI

```swift
import SwiftUI

struct InternationalTextEntry: View {
    @State private var text = "日々のひらめき"

    var body: some View {
        TextField("Sample text", text: $text, axis: .vertical)
            .lineLimit(1...4)
            .textInputAutocapitalization(.never)
            .environment(\.locale, Locale(identifier: "ja"))
            .padding()
        // Avoid replacing the binding on every keystroke;
        // composition may not be committed yet.
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Locale notes

Capture includes hand-authored Japanese, Arabic, Hindi, Korean, and Thai fixture strings with per-row locale/direction overrides. Keyboard language follows the person’s enabled keyboards; the app does not change it. Native-speaker review and IME/dictation input checks remain pending.

## Full example

[Open the complete runnable example](InternationalScriptInputDemo.swift).

## Reference

[Apple: TextField](https://developer.apple.com/documentation/swiftui/textfield).
