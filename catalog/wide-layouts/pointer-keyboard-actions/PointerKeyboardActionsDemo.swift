import SwiftUI

struct PointerKeyboardActionsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var title = "A place to begin"
    @State private var note = "Start with one small idea. Leave space for the next."
    @State private var savedTitle = "A place to begin"
    @State private var savedNote = "Start with one small idea. Leave space for the next."
    @State private var status = "All changes saved"
    @FocusState private var editingTitle: Bool
    private var dirty: Bool { title != savedTitle || note != savedNote }
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Label("QUICK NOTE", systemImage: "pencil.and.outline").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
            TextField("Title", text: $title).font(.system(.largeTitle, design: .serif)).focused($editingTitle)
            TextEditor(text: $note).font(.body).scrollContentBackground(.hidden)
                .frame(minHeight: 160, maxHeight: 360).accessibilityLabel("Note body")
            Divider()
            HStack(spacing: 16) {
                Button("New", systemImage: "square.and.pencil") {
                    title = ""; note = ""; status = "New note"; editingTitle = true
                }
                .keyboardShortcut("n", modifiers: .command)
                .hoverEffect(.lift)
                Spacer()
                Button("Save", systemImage: "checkmark") {
                    savedTitle = title; savedNote = note; status = "Saved"; editingTitle = false
                }
                .keyboardShortcut("s", modifiers: .command)
                .buttonStyle(.borderedProminent).disabled(!dirty)
                .hoverEffect(.lift)
            }
            Text(dirty ? "Unsaved changes" : status).font(.footnote).foregroundStyle(.secondary)
                .accessibilityLabel("Save status")
            if !capturing {
                Text("⌘N creates a note. ⌘S saves it. Pointer hover highlights each action.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(28).frame(maxWidth: 720).frame(maxWidth: .infinity)
        .navigationTitle("Notebook").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { PointerKeyboardActionsDemo() } }
