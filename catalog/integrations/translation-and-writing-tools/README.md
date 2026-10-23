---
id: "translation-and-writing-tools"
title: "Translation and Writing Tools"
summary: "Offer system language tools beside editable text."
category: "Integrations"
family: "Text services"
order: 2907
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TranslationWritingToolsDemo.swift"
view: "TranslationWritingToolsDemo"
apis: ["translationPresentation", "TextEditor", "writingToolsBehavior"]
tags: ["translation", "writing-tools", "editable-text", "system-availability"]
captureNavigation: true
captureStyle: "screen"
---

# Translation and Writing Tools

The translation presentation handles language selection and translation in native system UI, while Writing Tools can appear in the editing menu of supported editable text. Availability depends on device, language, and system settings; this local note remains editable without either service, and translation opens only from a tap.

## SwiftUI

```swift
import SwiftUI
import Translation

struct TranslationRecipe: View {
    @State private var text = "A quiet morning by the harbor."
    @State private var translate = false
    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $text).frame(height: 180).writingToolsBehavior(.complete)
            Button("Translate") { translate = true }
        }.padding()
        .translationPresentation(isPresented: $translate, text: text) { text = $0 }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](TranslationWritingToolsDemo.swift).

## Reference

[Apple: Translation](https://developer.apple.com/documentation/translation).
