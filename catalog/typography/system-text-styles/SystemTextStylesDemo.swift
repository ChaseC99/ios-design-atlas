import SwiftUI

struct SystemTextStylesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var bold = false
    private let styles: [(String, Font)] = [("Large title", .largeTitle), ("Title", .title), ("Title 2", .title2), ("Title 3", .title3), ("Headline", .headline), ("Body", .body), ("Callout", .callout), ("Subheadline", .subheadline), ("Footnote", .footnote), ("Caption", .caption), ("Caption 2", .caption2)]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                if !capturing { Toggle("Bold text", isOn: $bold) }
                ForEach(styles.indices, id: \.self) { index in
                    HStack(alignment: .firstTextBaseline) {
                        Text(styles[index].0).font(styles[index].1).bold(bold)
                        Spacer()
                        Text(String(format: "%02d", index + 1)).font(.caption.monospaced()).foregroundStyle(.tertiary)
                    }
                    if index < styles.count - 1 { Divider() }
                }
            }.padding(28).frame(maxWidth: 680)
        }
        .navigationTitle("The system type scale").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { SystemTextStylesDemo() } }
