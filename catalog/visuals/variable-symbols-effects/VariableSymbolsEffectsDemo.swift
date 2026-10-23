import SwiftUI

struct VariableSymbolsEffectsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var level = 0.65
    @State private var bounce = 0
    @State private var playing = false
    @State private var pulse = false
    var body: some View {
        VStack(spacing: 44) {
            Spacer()
            Image(systemName: "speaker.wave.3.fill", variableValue: level)
                .symbolRenderingMode(.hierarchical).foregroundStyle(.teal)
                .font(.system(size: 90)).accessibilityLabel("Volume").accessibilityValue("\(Int(level * 100)) percent")
            HStack(spacing: 44) {
                Button { bounce += 1 } label: {
                    Image(systemName: "bell.fill").symbolEffect(.bounce, value: bounce)
                        .font(.system(size: 42)).frame(width: 80, height: 80)
                }.accessibilityLabel("Ring bell")
                Button { withAnimation { playing.toggle() } } label: {
                    Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill")
                        .contentTransition(.symbolEffect(.replace))
                        .font(.system(size: 54)).frame(width: 80, height: 80)
                }.accessibilityLabel(playing ? "Pause" : "Play")
            }.buttonStyle(.plain).foregroundStyle(.indigo)
            Image(systemName: "heart.fill").font(.system(size: 42)).foregroundStyle(.pink)
                .symbolEffect(.pulse, isActive: pulse && !capturing)
            Spacer()
            if !capturing {
                Slider(value: $level, in: 0...1) { Text("Volume") }
                Toggle("Pulse the heart", isOn: $pulse)
            }
        }.padding(32).symbolEffectsRemoved(reduceMotion || capturing)
        .navigationTitle("Symbols in motion").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { VariableSymbolsEffectsDemo() } }
