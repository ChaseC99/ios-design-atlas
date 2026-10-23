import SwiftUI

@available(iOS 26.0, *)
struct RichTextEditorDemo: View {
    @State private var text: AttributedString = {
        var value = AttributedString("A note to remember\n\nTake the slower route. Leave a little room for the unexpected.")
        if let range = value.range(of: "A note to remember") { value[range].font = .title2.bold() }
        return value
    }()
    @State private var selection = AttributedTextSelection()
    var body: some View {
        TextEditor(text: $text, selection: $selection)
            .padding(20)
            .navigationTitle("Notebook").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Bold", systemImage: "bold") {
                        text.transformAttributes(in: &selection) { $0.font = .body.bold() }
                    }
                    Button("Italic", systemImage: "italic") {
                        text.transformAttributes(in: &selection) { $0.font = .body.italic() }
                    }
                    Button("Accent color", systemImage: "paintpalette") {
                        text.transformAttributes(in: &selection) { $0.foregroundColor = .teal }
                    }
                    Spacer()
                    Button("Clear formatting", systemImage: "textformat") {
                        text.transformAttributes(in: &selection) { attributes in
                            attributes.font = .body; attributes.foregroundColor = .primary
                        }
                    }
                }
            }
            .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { RichTextEditorDemo() } } }
