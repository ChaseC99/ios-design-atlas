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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Grammatical agreement on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765883.484.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Grammatical agreement on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765639.742.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Grammatical agreement on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767865.128.png)
<!-- captures:end -->

## Locale notes

English source copy with a local en_US locale override demonstrates system grammatical agreement. Production translations need String Catalog plural variations and language-specific review; this sample does not claim equivalent grammar in every language.

## Full example

[Open the complete runnable example](GrammaticalPluralAgreementDemo.swift).

## Reference

[Apple: Text](https://developer.apple.com/documentation/foundation/inflectionrule).
