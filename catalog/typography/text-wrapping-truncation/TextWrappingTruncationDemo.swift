import SwiftUI

struct TextWrappingTruncationDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var narrow = false
    private let phrase = "Somewhere between the sea and the sky"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                if !capturing { Toggle("Narrow reading column", isOn: $narrow) }
                example("WRAP") { Text(phrase).lineLimit(nil) }
                example("TRUNCATE AT END") { Text(phrase).lineLimit(1).truncationMode(.tail) }
                example("TRUNCATE IN MIDDLE") { Text(phrase).lineLimit(1).truncationMode(.middle) }
                example("SCALE TO FIT") { Text(phrase).lineLimit(1).minimumScaleFactor(0.5) }
                example("PRESERVE VERTICAL SIZE") { Text(phrase).fixedSize(horizontal: false, vertical: true) }
            }.frame(maxWidth: narrow ? 220 : 520, alignment: .leading).padding(28).frame(maxWidth: .infinity)
        }
        .navigationTitle("Text that fits").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func example<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.caption2).tracking(1.6).foregroundStyle(.secondary)
            content().font(.title2).frame(maxWidth: .infinity, alignment: .leading)
                .padding(16).background(Color.teal.opacity(0.07), in: RoundedRectangle(cornerRadius: 18))
        }
    }
}
#Preview { NavigationStack { TextWrappingTruncationDemo() } }
