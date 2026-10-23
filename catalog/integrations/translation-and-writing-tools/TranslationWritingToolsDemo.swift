import SwiftUI
import Translation

struct TranslationWritingToolsDemo: View {
    @State private var text = "A quiet morning by the harbor. We took the long way home, past the old lighthouse and the gardens by the water."
    @State private var translate = false
    @State private var replacements = 0
    var body: some View {
        Form {
            Section {
                Label("Field notes", systemImage: "text.book.closed.fill").font(.title2.bold()).foregroundStyle(.teal)
                TextEditor(text: $text).frame(minHeight: 260).writingToolsBehavior(.complete)
            }
            Section {
                Button("Translate note", systemImage: "translate") { translate = true }.disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                Button("Reset note") { text = "A quiet morning by the harbor. We took the long way home, past the old lighthouse and the gardens by the water."; replacements = 0 }
                LabeledContent("Translation replacements", value: "\(replacements)")
            }
            Section {
                Text("Select editable text to find the available system editing tools.").font(.caption).foregroundStyle(.secondary)
            }
        }
        .translationPresentation(isPresented: $translate, text: text) { text = $0; replacements += 1 }
        .navigationTitle("Language tools").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { TranslationWritingToolsDemo() } }
