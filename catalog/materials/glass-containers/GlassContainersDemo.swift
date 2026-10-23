import SwiftUI

@available(iOS 26.0, *)
struct GlassContainersDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Namespace private var namespace
    @State private var distance = 12.0
    @State private var threshold = 32.0
    @State private var joined = false
    @State private var selected = "sun.max"
    private let symbols = ["sun.max", "cloud", "moon"]
    var body: some View {
        ZStack {
            GlassContainersDemoBackdrop()
            VStack(spacing: 56) {
                GlassEffectContainer(spacing: threshold) {
                    HStack(spacing: distance) {
                        ForEach(symbols, id: \.self) { symbol in
                            Button { selected = symbol } label: {
                                Image(systemName: symbol).font(.title).frame(width: 72, height: 72)
                            }
                            .buttonStyle(.plain)
                            .glassEffect(.regular.tint(selected == symbol ? .teal : nil).interactive(), in: Circle())
                            .glassEffectUnion(id: joined ? "weather" : symbol, namespace: namespace)
                            .accessibilityLabel(symbol == "sun.max" ? "Sun" : symbol == "cloud" ? "Cloud" : "Moon")
                            .accessibilityAddTraits(selected == symbol ? .isSelected : [])
                        }
                    }
                }
                if !capturing {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Element spacing: \(Int(distance)) pt").font(.caption)
                        Slider(value: $distance, in: 0...36, step: 2)
                        Text("Container spacing: \(Int(threshold)) pt").font(.caption)
                        Slider(value: $threshold, in: 0...64, step: 2)
                        Toggle("Use one union", isOn: $joined)
                    }.padding(24).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 28))
                }
            }.padding(24)
        }
        .navigationTitle("Glass container").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct GlassContainersDemoBackdrop: View {
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

#Preview { if #available(iOS 26.0, *) { NavigationStack { GlassContainersDemo() } } }
