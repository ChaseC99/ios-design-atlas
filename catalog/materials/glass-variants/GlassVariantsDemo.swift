import SwiftUI

@available(iOS 26.0, *)
struct GlassVariantsDemo: View {
    @State private var selected: String?
    var body: some View {
        ZStack {
            GlassVariantsDemoBackdrop()
            VStack(spacing: 40) {
                glassButton("Regular", symbol: "sparkle", glass: .regular)
                glassButton("Clear", symbol: "drop", glass: .clear)
                glassButton("Tinted", symbol: "heart", glass: .regular.tint(.pink))
            }.padding(32)
        }
        .navigationTitle("Liquid Glass").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func glassButton(_ name: String, symbol: String, glass: Glass) -> some View {
        Button { selected = selected == name ? nil : name } label: {
            Label(selected == name ? "Selected" : name, systemImage: selected == name ? "checkmark" : symbol)
                .font(.title3.weight(.medium)).frame(maxWidth: .infinity).padding(24)
        }
        .buttonStyle(.plain)
        .glassEffect(glass.interactive(), in: Capsule())
        .accessibilityAddTraits(selected == name ? .isSelected : [])
    }
}

private struct GlassVariantsDemoBackdrop: View {
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

#Preview { if #available(iOS 26.0, *) { NavigationStack { GlassVariantsDemo() } } }
