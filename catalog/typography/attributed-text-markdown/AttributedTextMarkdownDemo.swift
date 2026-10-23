import SwiftUI

struct AttributedTextMarkdownDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var emphasized = true
    private var styled: AttributedString {
        var text = AttributedString("Pay attention to the small things.")
        if let range = text.range(of: "small things"), emphasized {
            text[range].foregroundColor = .teal
            text[range].font = .system(.title2, design: .serif).italic()
            text[range].underlineStyle = .single
        }
        return text
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Words with\na little more.").font(.system(.largeTitle, design: .serif))
                Text("**Slow down.** Take the long way. *Notice what you usually miss.*")
                    .font(.title3).lineSpacing(6)
                Divider()
                Text(styled).font(.title2).lineSpacing(6)
                Text("A `Text` view can include **emphasis**, *italics*, and a [link to SwiftUI](https://developer.apple.com/swiftui/).")
                    .font(.body).lineSpacing(6).tint(.teal)
                if !capturing { Toggle("Style the phrase", isOn: $emphasized) }
            }.padding(28).frame(maxWidth: 640)
        }
        .navigationTitle("Rich text").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { AttributedTextMarkdownDemo() } }
