import SwiftUI

@available(iOS 27.1, *)
struct SplitArrangementsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var horizontalOnly = false
    @State private var playing = false
    @State private var track = "The quiet hours"
    var body: some View {
        ArrangementView {
            VStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 30).fill(.teal.gradient)
                    .overlay(Image(systemName: "waveform").font(.system(size: 76, weight: .light)).foregroundStyle(.white))
                    .aspectRatio(1, contentMode: .fit).frame(maxWidth: 280)
                Text(track).font(.system(.title2, design: .serif))
                Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.fill" : "play.fill") { playing.toggle() }
                    .buttonStyle(.glass).controlSize(.large)
            }.padding(24).frame(maxWidth: .infinity, maxHeight: .infinity)
        } secondary: {
            List {
                Section("Up next") {
                    ForEach(["The quiet hours", "A wider world", "Slow mornings", "After the rain"], id: \.self) { name in
                        Button { track = name } label: {
                            HStack {
                                Label(name, systemImage: "waveform").foregroundStyle(.primary)
                                Spacer()
                                if track == name { Image(systemName: "checkmark").foregroundStyle(.teal) }
                            }.padding(.vertical, 10)
                        }
                    }
                }
            }
        }
        .arrangementViewStyle(.split.axes(horizontalOnly ? Axis.Set.horizontal : Axis.Set.horizontal.union(.vertical)))
        .navigationTitle("Listening room").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !capturing {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu { Toggle("Horizontal splits only", isOn: $horizontalOnly) } label: { Label("Layout", systemImage: "rectangle.split.2x1") }
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.1, *) { NavigationStack { SplitArrangementsDemo() } } }
