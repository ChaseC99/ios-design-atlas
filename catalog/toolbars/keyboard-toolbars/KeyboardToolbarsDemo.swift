import SwiftUI

struct KeyboardToolbarsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private enum Field: Int, CaseIterable { case title, place, note }
    @FocusState private var focused: Field?
    @State private var title = "Morning walk"
    @State private var place = "Ocean Beach"
    @State private var note = "The light was different today."
    var body: some View {
        Form {
            Section("Field note") {
                TextField("Title", text: $title).focused($focused, equals: .title).submitLabel(.next)
                TextField("Place", text: $place).focused($focused, equals: .place).submitLabel(.next)
                TextField("Observation", text: $note, axis: .vertical).focused($focused, equals: .note).lineLimit(3...6)
            }
            Section { Label("Only stored in this demo", systemImage: "lock").foregroundStyle(.secondary) }
        }
        .onSubmit { move(1) }
        .navigationTitle("New note").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous field", systemImage: "chevron.up") { move(-1) }.disabled(focused == .title)
                Button("Next field", systemImage: "chevron.down") { move(1) }.disabled(focused == .note)
                Spacer()
                Button("Done") { focused = nil }
            }
        }
        .task {
            if capturing {
                try? await Task.sleep(for: .milliseconds(300))
                focused = .title
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
    private func move(_ offset: Int) {
        guard let focused else { return }
        self.focused = Field(rawValue: focused.rawValue + offset)
    }
}
#Preview { NavigationStack { KeyboardToolbarsDemo() } }
