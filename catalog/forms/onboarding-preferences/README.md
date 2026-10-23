---
id: "onboarding-preferences"
title: "Onboarding and preferences"
summary: "A short introduction leads into useful choices and a clear completion state."
category: "Forms"
family: "Flows"
order: 2505
kind: "native"
demoMinIOS: "18.0"
swiftFile: "OnboardingPreferencesDemo.swift"
view: "OnboardingPreferencesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["TabView", "tabViewStyle", "Button", "Toggle"]
tags: ["onboarding", "page indicators", "preferences", "completion"]
---

# Onboarding and preferences

A short introduction leads into useful choices and a clear completion state.

## SwiftUI

```swift
import SwiftUI

struct IntroPages: View {
    @State private var page = 0

    var body: some View {
        VStack {
            TabView(selection: $page) {
                Label("Keep good things close", systemImage: "bookmark").tag(0)
                Label("Find your next favorite", systemImage: "sparkles").tag(1)
            }
            .tabViewStyle(.page)
            Button("Continue") { withAnimation { page = min(1, page + 1) } }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Onboarding and preferences on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770844.885.png)
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](OnboardingPreferencesDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).
