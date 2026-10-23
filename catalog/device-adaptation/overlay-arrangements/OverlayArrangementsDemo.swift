import SwiftUI

@available(iOS 27.1, *)
struct OverlayArrangementsDemo: View {
    @State private var saved = false
    @State private var information = false
    var body: some View {
        ArrangementView {
            VStack(alignment: .leading, spacing: 16) {
                Text("The edge of the day.").font(.system(.title, design: .serif))
                Text("A study in changing light").foregroundStyle(.secondary)
                HStack(spacing: 16) {
                    Button(saved ? "Saved" : "Save", systemImage: saved ? "checkmark" : "bookmark") { saved.toggle() }
                        .buttonStyle(.glassProminent)
                    Button("Details", systemImage: "info.circle") { information.toggle() }.buttonStyle(.glass)
                }
                if information { Text("Original artwork · Color study 04").font(.caption).foregroundStyle(.secondary) }
            }
            .padding(24).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 28))
            .padding(24).frame(maxWidth: 520).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .overlayArrangementEdge(.bottom)
        } secondary: {
            GeometryReader { geometry in
                ZStack {
                    LinearGradient(colors: [.indigo, .purple, .orange], startPoint: .top, endPoint: .bottom)
                    Circle().fill(.orange.opacity(0.8)).frame(width: min(geometry.size.width, geometry.size.height) * 0.5)
                        .offset(x: geometry.size.width * 0.15, y: -geometry.size.height * 0.15)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .arrangementViewStyle(.overlay)
        .navigationTitle("Light study").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.1, *) { NavigationStack { OverlayArrangementsDemo() } } }
