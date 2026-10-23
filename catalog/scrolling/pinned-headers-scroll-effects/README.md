---
id: "pinned-headers-scroll-effects"
title: "Pinned headers and scroll effects"
summary: "Keep section context visible as cards enter and leave the viewport."
category: "Scrolling"
family: "Effects"
order: 608
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PinnedHeadersScrollEffectsDemo.swift"
view: "PinnedHeadersScrollEffectsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["LazyVStack", "scrollTransition"]
tags: ["sticky headers", "visual effects", "reduce motion"]
---

# Pinned headers and scroll effects

Pinned section headers keep a section’s title visible, while scroll transitions can change a card as it enters or leaves the viewport.

## SwiftUI

```swift
import SwiftUI

struct PinnedSections: View {
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ForEach(["Morning", "Evening"], id: \.self) { title in
                    Section {
                        ForEach(1...12, id: \.self) { number in
                            Text("Study \(number)").padding(32)
                        }
                    } header: {
                        Text(title).font(.headline)
                            .frame(maxWidth: .infinity).padding()
                            .background(.regularMaterial)
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

![Pinned headers and scroll effects on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766346.845.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Pinned headers and scroll effects on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766147.427.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PinnedHeadersScrollEffectsDemo.swift).

## Reference

[Apple: LazyVStack](https://developer.apple.com/documentation/swiftui/lazyvstack).
