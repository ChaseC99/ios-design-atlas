---
id: "bottom-anchored-chat"
title: "Bottom-anchored conversations"
summary: "Start at the latest message and keep new replies in view."
category: "Scrolling"
family: "Anchoring"
order: 604
kind: "native"
demoMinIOS: "18.0"
swiftFile: "BottomAnchoredChatDemo.swift"
view: "BottomAnchoredChatDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["defaultScrollAnchor", "ScrollViewReader", "scrollDismissesKeyboard"]
tags: ["chat", "bottom", "keyboard"]
---

# Bottom-anchored conversations

A bottom scroll anchor starts a conversation at its newest content; explicit scrolling can follow new messages when appropriate.

## SwiftUI

```swift
import SwiftUI

struct LatestMessages: View {
    @State private var messages = ["Hello", "Welcome back"]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(messages.indices, id: \.self) { index in
                        Text(messages[index]).padding().id(index)
                    }
                }.frame(maxWidth: .infinity)
            }
            .defaultScrollAnchor(.bottom)
            .onChange(of: messages.count) { _, _ in
                withAnimation { proxy.scrollTo(messages.count - 1, anchor: .bottom) }
            }
            .safeAreaInset(edge: .bottom) {
                Button("Add reply") { messages.append("A new message") }.padding()
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Bottom-anchored conversations on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765396.244.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Bottom-anchored conversations on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765361.521.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Bottom-anchored conversations on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767587.698.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](BottomAnchoredChatDemo.swift).

## Reference

[Apple: defaultScrollAnchor](https://developer.apple.com/documentation/swiftui/view/defaultscrollanchor(_:)).
