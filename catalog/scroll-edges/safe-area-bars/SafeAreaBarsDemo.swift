import SwiftUI

@available(iOS 26.0, *)
struct SafeAreaBarsDemo: View {
    @State private var selected = "All"
    @State private var playing = false
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 18) {
                ForEach(0..<12) { index in
                    HStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill([Color.teal, .indigo, .orange][index % 3].gradient)
                            Image(systemName: "waveform").font(.largeTitle).foregroundStyle(.white)
                        }.frame(width: 84, height: 84)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(["The quiet hours", "A wider world", "Slow mornings"][index % 3]).font(.headline)
                            Text("Session \(index + 1) · 28 min").foregroundStyle(.secondary).font(.subheadline)
                        }
                        Spacer(minLength: 0)
                    }.padding(.vertical, 8)
                }
            }.padding(24)
        }
        .safeAreaBar(edge: .top, spacing: 0) {
            HStack {
                ForEach(["All", "Saved", "Downloaded"], id: \.self) { item in
                    Button(item) { selected = item }
                        .buttonStyle(.glass).tint(selected == item ? .teal : nil)
                }
                Spacer(minLength: 0)
            }.padding(.horizontal, 24).padding(.vertical, 12)
        }
        .safeAreaBar(edge: .bottom, spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: "waveform").font(.title2).foregroundStyle(.teal)
                VStack(alignment: .leading) {
                    Text("The quiet hours").font(.subheadline.bold())
                    Text("Session 01").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.fill" : "play.fill") { playing.toggle() }
                    .labelStyle(.iconOnly).buttonStyle(.glass).controlSize(.large)
            }.padding(16).glassEffect(in: RoundedRectangle(cornerRadius: 28))
                .padding(.horizontal, 20).padding(.vertical, 8)
        }
        .scrollEdgeEffectStyle(.soft, for: .vertical)
        .navigationTitle("Listen").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { SafeAreaBarsDemo() } } }
