import SwiftUI

struct AdaptiveMediaCompositionDemo: View {
    @State private var playing = false
    @State private var progress = 0.35
    var body: some View {
        GeometryReader { proxy in
            let sideBySide = proxy.size.width > 700 && proxy.size.width > proxy.size.height
            let layout = sideBySide ? AnyLayout(HStackLayout(spacing: 32)) : AnyLayout(VStackLayout(spacing: 32))
            ScrollView {
                layout {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30).fill(.indigo.gradient)
                        Circle().fill(.orange).frame(width: 130).offset(x: 45, y: -30)
                        Image(systemName: "waveform").font(.system(size: 72, weight: .ultraLight)).foregroundStyle(.white)
                    }.aspectRatio(sideBySide ? 1.4 : 1, contentMode: .fit).frame(maxWidth: 600)
                    VStack(alignment: .leading, spacing: 24) {
                        Text("The quiet hours").font(.system(.largeTitle, design: .serif))
                        Text("A visual playback study").foregroundStyle(.secondary)
                        Slider(value: $progress, in: 0...1) { Text("Playback position") }
                        HStack(spacing: 32) {
                            Button("Back 15 seconds", systemImage: "gobackward.15") { progress = max(0, progress - 0.05) }
                            Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.circle.fill" : "play.circle.fill") { playing.toggle() }
                                .font(.system(size: 48))
                            Button("Forward 15 seconds", systemImage: "goforward.15") { progress = min(1, progress + 0.05) }
                        }.labelStyle(.iconOnly).buttonStyle(.plain).font(.title2)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }.padding(28).frame(maxWidth: 1200).frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Now playing").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { AdaptiveMediaCompositionDemo() } }
