import SwiftUI

struct SheetKeyboardDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private enum Field: Hashable { case title, note }
    @State private var isPresented = false
    @State private var focusOnOpen = true
    @State private var title = "Saturday by the sea"
    @State private var note = "Meet at the harbor, then follow the coastal path."
    @FocusState private var focusedField: Field?

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Toggle("Focus the title on opening", isOn: $focusOnOpen)
                    Button("New field note") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Keyboards inside sheets")
        .sheet(isPresented: $isPresented, onDismiss: { focusedField = nil }) {
            NavigationStack {
                Form {
                    Section("Title") {
                        TextField("A name for this moment", text: $title)
                            .focused($focusedField, equals: .title)
                            .accessibilityIdentifier("capture-focus")
                            .submitLabel(.next)
                            .onSubmit { focusedField = .note }
                    }
                    Section("Note") {
                        TextField("What would you like to remember?", text: $note, axis: .vertical)
                            .lineLimit(3...8)
                            .focused($focusedField, equals: .note)
                    }
                    Section {
                        Label("Weekend references", systemImage: "folder")
                        Label("Only you", systemImage: "lock")
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .navigationTitle("New field note")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { isPresented = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { isPresented = false }.disabled(title.isEmpty)
                    }
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Title") { focusedField = .title }
                        Button("Note") { focusedField = .note }
                        Spacer()
                        Button("Done") { focusedField = nil }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .accessibilityIdentifier("capture-ready")
            .task {
                guard focusOnOpen else { return }
                try? await Task.sleep(for: .milliseconds(450))
                guard !Task.isCancelled else { return }
                focusedField = .title
            }
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { SheetKeyboardDemo() } }
