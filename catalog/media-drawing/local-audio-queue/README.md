---
id: "local-audio-queue"
title: "An audio queue with a mini player"
summary: "Play a short local tone and expand its controls."
category: "Media & drawing"
family: "Playback"
order: 2605
kind: "native"
demoMinIOS: "18.0"
swiftFile: "LocalAudioQueueDemo.swift"
view: "LocalAudioQueueDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["AVAudioPlayer", "presentationDetents", "TimelineView"]
tags: ["audio", "queue", "mini player"]
---

# An audio queue with a mini player

A compact player and expanded sheet share playback state; the three sample clips are quiet synthesized tones generated locally, with no recorded or licensed audio.

## SwiftUI

```swift
import SwiftUI
import AVFAudio

struct LocalAudioButton: View {
    let localURL: URL
    @State private var player: AVAudioPlayer?
    @State private var failed = false
    var body: some View {
        VStack {
            Button("Play", systemImage: "play.fill") {
                do {
                    player = try AVAudioPlayer(contentsOf: localURL)
                    failed = !(player?.play() ?? false)
                } catch { failed = true }
            }
            Button("Pause", systemImage: "pause.fill") { player?.pause() }
            if failed { Text("Audio could not be played.") }
        }.onDisappear { player?.stop() }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![An audio queue with a mini player on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770734.858.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](LocalAudioQueueDemo.swift).

## Reference

[Apple: AVAudioPlayer](https://developer.apple.com/documentation/avfaudio/avaudioplayer).
