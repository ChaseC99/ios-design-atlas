import SwiftUI

struct AdaptiveMaterialFallbackDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var contrast
    @State private var previewOpaque = false
    @State private var previewFallback = false
    @State private var saved = false
    private var opaque: Bool { reduceTransparency || previewOpaque }
    var body: some View {
        ZStack {
            AdaptiveMaterialFallbackDemoBackdrop()
            VStack(spacing: 48) {
                surface
                if !capturing {
                    VStack(alignment: .leading, spacing: 18) {
                        Toggle("Preview opaque surface", isOn: $previewOpaque)
                        Toggle("Preview material fallback", isOn: $previewFallback)
                        LabeledContent("Reduce Transparency", value: reduceTransparency ? "On" : "Off")
                        LabeledContent("Contrast", value: contrast == .increased ? "Increased" : "Standard")
                    }.font(.subheadline).padding(24)
                        .background(Color(uiColor: .systemBackground), in: RoundedRectangle(cornerRadius: 26))
                }
            }.padding(28)
        }
        .navigationTitle("Adaptive surfaces").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var control: some View {
        Button { saved.toggle() } label: {
            Label(saved ? "Saved to your collection" : "Save to your collection", systemImage: saved ? "checkmark" : "bookmark")
                .font(.headline).padding(24).frame(maxWidth: .infinity)
        }.buttonStyle(.plain)
    }
    @ViewBuilder private var surface: some View {
        if opaque {
            control.background(Color(uiColor: .systemBackground), in: Capsule())
                .overlay(Capsule().strokeBorder(Color.primary.opacity(contrast == .increased ? 0.6 : 0.15), lineWidth: contrast == .increased ? 2 : 1))
        } else if #available(iOS 26.0, *), !previewFallback {
            control.glassEffect(.regular.interactive())
        } else {
            control.background(.regularMaterial, in: Capsule())
                .overlay(Capsule().strokeBorder(Color.primary.opacity(contrast == .increased ? 0.6 : 0.1), lineWidth: contrast == .increased ? 2 : 1))
        }
    }
}

private struct AdaptiveMaterialFallbackDemoBackdrop: View {
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

#Preview { NavigationStack { AdaptiveMaterialFallbackDemo() } }
