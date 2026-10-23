import SwiftUI

struct MatchedGeometryDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var geometry
    @State private var expanded = false
    @State private var previewReducedMotion = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                ZStack(alignment: .topLeading) {
                    if expanded {
                        VStack(alignment: .leading, spacing: 24) {
                            artwork.matchedGeometryEffect(id: "art", in: geometry).frame(height: 180)
                            Text("A quieter morning").font(.title.bold()).matchedGeometryEffect(id: "title", in: geometry)
                            Text("Take the coastal path before the town wakes up.").font(.title3).foregroundStyle(.secondary)
                        }
                    } else {
                        HStack(spacing: 20) {
                            artwork.matchedGeometryEffect(id: "art", in: geometry).frame(width: 88, height: 88)
                            Text("A quieter morning").font(.headline).matchedGeometryEffect(id: "title", in: geometry)
                        }
                    }
                }.frame(maxWidth: .infinity, minHeight: 340, alignment: .topLeading)
                Button(expanded ? "Show compact card" : "Expand card") {
                    withAnimation(reduceMotion || previewReducedMotion ? nil : .spring(duration: 0.6, bounce: 0.12)) {
                        expanded.toggle()
                    }
                }.buttonStyle(.borderedProminent)
                Toggle("Preview reduced motion", isOn: $previewReducedMotion)
            }.padding(28).frame(maxWidth: 600).frame(maxWidth: .infinity)
        }
        .navigationTitle("Matched geometry")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .task { if isCapturing { expanded = true } }
    }
    private var artwork: some View {
        RoundedRectangle(cornerRadius: 24).fill(.orange.opacity(0.15))
            .overlay { Image(systemName: "sun.horizon.fill").font(.system(size: expanded ? 72 : 36)).foregroundStyle(.orange) }
    }
}

#Preview { NavigationStack { MatchedGeometryDemo() } }
