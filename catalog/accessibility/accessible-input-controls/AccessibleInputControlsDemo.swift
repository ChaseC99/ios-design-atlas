import SwiftUI

struct AccessibleInputControlsDemo: View {
    @State private var playing = false
    @State private var track = 1
    @FocusState private var playFocused: Bool
    var body: some View {
        VStack(spacing: 28) {
            ZStack {
                RoundedRectangle(cornerRadius: 30).fill(.indigo.gradient)
                Image(systemName: "waveform").font(.system(size: 100)).foregroundStyle(.white.opacity(0.9)).accessibilityHidden(true)
            }.frame(height: 280)
            VStack(spacing: 8) {
                Text(["Blue hour", "Still water", "Somewhere familiar"][(track - 1) % 3]).font(.title.bold())
                Text("Atlas Sessions · Sample player").foregroundStyle(.secondary)
            }.accessibilityElement(children: .combine)
            HStack(spacing: 32) {
                Button { track = max(1, track - 1) } label: { Image(systemName: "backward.end.fill").frame(minWidth: 52, minHeight: 52).contentShape(Rectangle()) }
                    .accessibilityLabel("Previous track").accessibilityInputLabels(["Previous track", "Previous"])
                    .keyboardShortcut(.leftArrow, modifiers: .command)
                Button { playing.toggle() } label: {
                    Image(systemName: playing ? "pause.fill" : "play.fill").font(.largeTitle).frame(minWidth: 72, minHeight: 72)
                }.buttonStyle(.borderedProminent).buttonBorderShape(.circle)
                    .accessibilityLabel(playing ? "Pause" : "Play").accessibilityInputLabels(playing ? ["Pause", "Pause playback"] : ["Play", "Start playback"])
                    .keyboardShortcut(.space, modifiers: []).focused($playFocused)
                Button { track += 1 } label: { Image(systemName: "forward.end.fill").frame(minWidth: 52, minHeight: 52).contentShape(Rectangle()) }
                    .accessibilityLabel("Next track").accessibilityInputLabels(["Next track", "Next"])
                    .keyboardShortcut(.rightArrow, modifiers: .command)
            }
            Text(playing ? "Playing" : "Paused").font(.subheadline).foregroundStyle(.secondary)
        }.padding(28)
            .navigationTitle("Listen").navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { AccessibleInputControlsDemo() } }
