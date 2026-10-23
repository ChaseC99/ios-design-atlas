import SwiftUI

struct MultilineTextFieldsDemo: View {
    @State private var text = "Find a new café. Take the coastal path. Leave a little room for the unexpected."
    @State private var saved = false
    @FocusState private var focused: Bool
    private let limit = 180
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text("A note for the weekend").font(.title2.weight(.semibold))
                    TextField("What would you like to remember?", text: $text, axis: .vertical)
                        .lineLimit(3...6).focused($focused).accessibilityIdentifier("capture-focus")
                    HStack {
                        if text.count > limit { Label("Shorten your note to save", systemImage: "exclamationmark.circle").foregroundStyle(.red) }
                        Spacer()
                        Text("\(text.count)/\(limit)").monospacedDigit().foregroundStyle(text.count > limit ? .red : .secondary)
                    }.font(.caption)
                }.padding(.vertical, 12)
            }
            Section {
                Button(saved ? "Note saved" : "Save note") { saved = true; focused = false }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || text.count > limit)
            }
        }
        .navigationTitle("New note").navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItemGroup(placement: .keyboard) { Spacer(); Button("Done") { focused = false } } }
        .onChange(of: text) { _, _ in saved = false }
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focused = true } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { MultilineTextFieldsDemo() } }
