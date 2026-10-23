import SwiftUI

@available(iOS 26.0, *)
struct GlassShapesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var interactive = true
    @State private var saved = false
    @State private var playing = false
    var body: some View {
        ZStack {
            GlassShapesDemoBackdrop()
            VStack(spacing: 42) {
                Button { playing.toggle() } label: {
                    Image(systemName: playing ? "pause.fill" : "play.fill")
                        .font(.system(size: 28)).frame(width: 88, height: 88)
                }.buttonStyle(.plain).glassEffect(.regular.interactive(interactive), in: Circle())
                    .accessibilityLabel(playing ? "Pause" : "Play")
                Button { saved.toggle() } label: {
                    Label(saved ? "Saved" : "Save for later", systemImage: saved ? "checkmark" : "bookmark")
                        .font(.title3.weight(.medium)).padding(.horizontal, 32).padding(.vertical, 22)
                }.buttonStyle(.plain).glassEffect(.regular.interactive(interactive), in: Capsule())
                HStack(spacing: 22) {
                    Image(systemName: "waveform").font(.largeTitle)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Quiet mornings").font(.headline)
                        Text("A moment to yourself").font(.subheadline).foregroundStyle(.secondary)
                    }
                }.padding(26).glassEffect(in: RoundedRectangle(cornerRadius: 28))
                if !capturing {
                    Toggle("Interactive controls", isOn: $interactive)
                        .padding(20).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
                }
            }.padding(28)
        }
        .navigationTitle("Glass shapes").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct GlassShapesDemoBackdrop: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(colors: [.indigo, .blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle().fill(.orange.gradient).frame(width: geometry.size.width * 0.85)
                    .offset(x: geometry.size.width * 0.25, y: -geometry.size.height * 0.16)
                Circle().fill(.mint.opacity(0.65)).frame(width: geometry.size.width * 1.1)
                    .offset(x: -geometry.size.width * 0.25, y: geometry.size.height * 0.34)
            }.frame(width: geometry.size.width, height: geometry.size.height).clipped()
        }.ignoresSafeArea().accessibilityHidden(true)
    }
}

#Preview { if #available(iOS 26.0, *) { NavigationStack { GlassShapesDemo() } } }
