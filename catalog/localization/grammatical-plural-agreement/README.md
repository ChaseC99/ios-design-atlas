---
id: "grammatical-plural-agreement"
title: "Grammatical agreement"
summary: "Automatic inflection can adjust supported words to a count while keeping the full phrase together."
category: "Localization"
family: "Formats"
order: 2105
kind: "native"
demoMinIOS: "18.0"
swiftFile: "GrammaticalPluralAgreementDemo.swift"
view: "GrammaticalPluralAgreementDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "English source copy with a local en_US locale override demonstrates system grammatical agreement. Production translations need String Catalog plural variations and language-specific review; this sample does not claim equivalent grammar in every language."
apis: ["Text", "LocalizedStringKey", "inflect"]
tags: ["plural", "singular", "grammar", "counts"]
---

# Grammatical agreement

Automatic inflection can adjust supported words to a count while keeping the full phrase together.

## SwiftUI

```swift
import SwiftUI

struct InflectedCount: View {
    @State private var count = 1

    var body: some View {
        VStack(spacing: 16) {
            Text("^[\(count) saved note](inflect: true)")
            Stepper("Count", value: $count, in: 0...20)
        }
        .environment(\.locale, Locale(identifier: "en_US"))
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Locale notes

English source copy with a local en_US locale override demonstrates system grammatical agreement. Production translations need String Catalog plural variations and language-specific review; this sample does not claim equivalent grammar in every language.

## Full example

[Open the complete runnable example](GrammaticalPluralAgreementDemo.swift).

## Reference

[Apple: Text](https://developer.apple.com/documentation/foundation/inflectionrule).
