---
id: "native-video-player"
title: "Native video playback"
summary: "Play an original local movie with the system player."
category: "Media & drawing"
family: "Playback"
order: 2604
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NativeVideoPlayerDemo.swift"
view: "NativeVideoPlayerDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["AVPlayerViewController", "AVAssetWriter", "AVPlayer"]
tags: ["video", "full screen", "offline fixture"]
---

# Native video playback

AVPlayerViewController supplies native playback and full-screen controls; this example generates its own silent movie locally, without downloaded media.

## SwiftUI

```swift
import SwiftUI
import AVKit

struct NativeMovie: UIViewControllerRepresentable {
    let player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        return controller
    }
    func updateUIViewController(_ controller: AVPlayerViewController, context: Context) {
        controller.player = player
    }
}
// Create AVPlayer(url: localMovieURL) and pass it to NativeMovie(player:).
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Native video playback on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770828.38.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeVideoPlayerDemo.swift).

## Reference

[Apple: AVPlayerViewController](https://developer.apple.com/documentation/avkit/avplayerviewcontroller).
