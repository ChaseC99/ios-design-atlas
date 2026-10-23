import SwiftUI

struct MaterialVersusOpacityDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var opacity = 0.65
    @State private var overlap = false
    var body: some View {
        ZStack {
            MaterialVersusOpacityDemoBackdrop()
            VStack(spacing: overlap ? -28 : 28) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Translucent color").font(.title2.bold())
                    Text("Background details remain visible.").foregroundStyle(.secondary)
                    Image(systemName: "circle.lefthalf.filled").font(.largeTitle).padding(.top, 20)
                }.frame(maxWidth: .infinity, alignment: .leading).padding(28)
                    .background(Color(uiColor: .systemBackground).opacity(opacity), in: RoundedRectangle(cornerRadius: 30))
                VStack(alignment: .leading, spacing: 12) {
                    Text("Regular material").font(.title2.bold())
                    Text("Background details are softened.").foregroundStyle(.secondary)
                    Image(systemName: "drop.halffull").font(.largeTitle).padding(.top, 20)
                }.frame(maxWidth: .infinity, alignment: .leading).padding(28)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 30))
                if !capturing {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Color opacity: \(Int(opacity * 100))%").font(.caption)
                        Slider(value: $opacity, in: 0.1...1)
                        Toggle("Overlap surfaces", isOn: $overlap)
                    }.padding(20).background(.thickMaterial, in: RoundedRectangle(cornerRadius: 24)).padding(.top, 28)
                }
            }.padding(24)
        }
        .navigationTitle("Surface layers").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct MaterialVersusOpacityDemoBackdrop: View {
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

#Preview { NavigationStack { MaterialVersusOpacityDemo() } }
