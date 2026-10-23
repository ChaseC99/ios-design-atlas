import SwiftUI

@available(iOS 26.0, *)
struct ScrollEdgeStylesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var style = 2
    @State private var bottomStyle = 0
    private let names = ["Automatic", "Hard", "Soft"]
    private var styles: [ScrollEdgeEffectStyle] { [.automatic, .hard, .soft] }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 18) {
                    if !capturing {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Top edge").font(.caption).foregroundStyle(.secondary)
                            Picker("Top edge", selection: $style) {
                                ForEach(0..<3) { Text(names[$0]).tag($0) }
                            }.pickerStyle(.segmented)
                            Text("Bottom edge").font(.caption).foregroundStyle(.secondary)
                            Picker("Bottom edge", selection: $bottomStyle) {
                                ForEach(0..<3) { Text(names[$0]).tag($0) }
                            }.pickerStyle(.segmented)
                        }.padding(.bottom, 8)
                    }
                    ForEach(0..<14) { index in
                        VStack(alignment: .leading, spacing: 52) {
                            Image(systemName: ["sun.max", "wind", "moon.stars"][index % 3])
                                .font(.system(size: 42, weight: .light))
                            HStack(alignment: .lastTextBaseline) {
                                Text(["Morning light", "Coastal air", "After hours"][index % 3])
                                    .font(.title2.bold())
                                Spacer()
                                Text(String(format: "%02d", index + 1)).monospacedDigit()
                            }
                        }
                        .foregroundStyle(.white).padding(28).frame(maxWidth: .infinity, alignment: .leading)
                        .background([Color.orange, .teal, .indigo][index % 3].gradient,
                                    in: RoundedRectangle(cornerRadius: 28))
                        .id(index)
                    }
                }.padding(20)
            }
            .scrollEdgeEffectStyle(styles[style], for: .top)
            .scrollEdgeEffectStyle(styles[bottomStyle], for: .bottom)
            .task { if capturing { proxy.scrollTo(1, anchor: .center) } }
        }
        .navigationTitle("Field notes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Label("A collection of quiet moments", systemImage: "square.stack")
                    .font(.subheadline)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { if #available(iOS 26.0, *) { NavigationStack { ScrollEdgeStylesDemo() } } }
