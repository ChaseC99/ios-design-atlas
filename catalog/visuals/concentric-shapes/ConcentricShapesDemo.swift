import SwiftUI

@available(iOS 26.0, *)
struct ConcentricShapesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var inset = 16.0
    @State private var shadow = true
    @State private var border = true
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 22) {
                    ZStack {
                        LinearGradient(colors: [.teal, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                        Image(systemName: "leaf").font(.system(size: 72, weight: .ultraLight)).foregroundStyle(.white)
                    }.frame(height: 250).clipShape(ConcentricRectangle())
                    VStack(alignment: .leading, spacing: 10) {
                        Text("A softer edge.").font(.system(.title, design: .serif))
                        Text("Nested surfaces with room to breathe.").foregroundStyle(.secondary)
                    }.padding(.horizontal, 8)
                    Text("FIELD STUDY").font(.caption2.weight(.semibold)).tracking(1.5)
                        .padding(.horizontal, 18).padding(.vertical, 10).background(.teal.opacity(0.12), in: Capsule()).padding(.horizontal, 8)
                }
                .padding(inset)
                .background(Color(uiColor: .systemBackground), in: RoundedRectangle(cornerRadius: 40))
                .containerShape(RoundedRectangle(cornerRadius: 40))
                .overlay(RoundedRectangle(cornerRadius: 40).strokeBorder(Color.primary.opacity(border ? 0.12 : 0), lineWidth: 1))
                .shadow(color: .black.opacity(shadow ? 0.12 : 0), radius: 18, y: 10)
                if !capturing {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Inset: \(Int(inset)) pt").font(.caption)
                        Slider(value: $inset, in: 8...28, step: 2)
                        Toggle("Border", isOn: $border)
                        Toggle("Shadow", isOn: $shadow)
                    }
                }
            }.padding(28).frame(maxWidth: 600)
        }.background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Corners and surfaces").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { ConcentricShapesDemo() } } }
