import SwiftUI

struct ContrastTransparencyAdaptationDemo: View {
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var contrast
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiate
    @State private var previewOpaque = false
    @State private var previewContrast = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var opaque: Bool { reduceTransparency || previewOpaque }
    private var increased: Bool { contrast == .increased || previewContrast }
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack {
                    LinearGradient(colors: [.indigo, .purple, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Everything in its place.").font(.title.bold())
                        status("Saved", symbol: "checkmark.circle.fill", color: .green)
                        status("Waiting to upload", symbol: "clock.fill", color: .orange)
                        status("Needs attention", symbol: "exclamationmark.triangle.fill", color: .red)
                    }
                    .padding(24)
                    .background(opaque ? AnyShapeStyle(Color(uiColor: .systemBackground)) : AnyShapeStyle(.regularMaterial), in: .rect(cornerRadius: 24))
                    .overlay { RoundedRectangle(cornerRadius: 24).stroke(increased ? Color.primary : .clear, lineWidth: 2) }
                    .padding(24)
                }.frame(minHeight: 400).clipShape(.rect(cornerRadius: 30))
                if !isCapturing {
                    Toggle("Preview opaque background", isOn: $previewOpaque)
                    Toggle("Preview stronger borders", isOn: $previewContrast)
                    LabeledContent("Differentiate Without Color", value: differentiate ? "Enabled" : "System default")
                }
            }.padding(20)
        }
        .navigationTitle("Clear in every setting").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func status(_ title: String, symbol: String, color: Color) -> some View {
        Label(title, systemImage: symbol).foregroundStyle(increased ? .primary : color)
            .font(.subheadline.weight(.medium))
    }
}

#Preview { NavigationStack { ContrastTransparencyAdaptationDemo() } }
