import SwiftUI

@available(iOS 26.0, *)
struct RichTextEditingDemo: View {
    @State private var text: AttributedString = {
        var title = AttributedString("A little room to wander\n\n")
        title.font = .system(.title, design: .serif).bold()
        var body = AttributedString("Take the longer route. Notice something familiar in a different way. Leave a little space for the unexpected.\n\nSome words are worth keeping.")
        body.font = .body
        if let range = body.range(of: "the unexpected") { body[range].foregroundColor = .indigo; body[range].font = .body.bold() }
        return title + body
    }()
    @State private var selection = AttributedTextSelection()
    @FocusState private var focused: Bool
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        VStack(spacing: 0) {
        TextEditor(text: $text, selection: $selection)
            .padding(20).focused($focused).accessibilityIdentifier("capture-focus")
            .navigationTitle("Field notes").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Bold", systemImage: "bold") { text.transformAttributes(in: &selection) { $0.font = .body.bold() } }
                    Button("Accent color", systemImage: "paintpalette") { text.transformAttributes(in: &selection) { $0.foregroundColor = .indigo } }
                    Button("Plain text", systemImage: "textformat") { text.transformAttributes(in: &selection) { $0.font = .body; $0.foregroundColor = .primary } }
                    Spacer()
                    Button("Done") { focused = false }
                }
            }
            .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focused = true } }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

@available(iOS 26.0, *)
#Preview { NavigationStack { RichTextEditingDemo() } }
