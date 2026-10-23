---
id: "sliders-and-steppers"
title: "Sliders and steppers"
summary: "Adjust a value continuously or one step at a time."
category: "Controls"
family: "Values"
order: 1203
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SlidersAndSteppersDemo.swift"
view: "SlidersAndSteppersDemo"
apis: ["Slider", "Stepper", "sensoryFeedback"]
tags: ["continuous", "stepped", "range", "feedback", "labels"]
captureNavigation: true
captureStyle: "screen"
---

# Sliders and steppers

A slider makes a range easy to explore, while a stepper gives precise bounded changes. Endpoint labels, formatted values, and subtle selection feedback make the scale and current value understandable.

## SwiftUI

```swift
import SwiftUI

struct SliderStepperRecipe: View {
    @State private var brightness = 0.6
    @State private var copies = 2
    var body: some View {
        Form {
            Slider(value: $brightness, in: 0...1) { Text("Brightness") }
            Stepper("Copies: \(copies)", value: $copies, in: 1...10)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Sliders and steppers on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766814.093.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Sliders and steppers on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766506.631.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Sliders and steppers on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768664.152.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SlidersAndSteppersDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).
