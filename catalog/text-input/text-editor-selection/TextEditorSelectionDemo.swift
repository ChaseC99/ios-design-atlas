import SwiftUI

struct TextEditorSelectionDemo: View {
    @State private var text = "A little room to wander\n\nThere is something good about a day without a strict plan. Take the longer route, notice a familiar place, and leave time for an unexpected conversation.\n\nKeep a few words here for later."
    @State private var selection: TextSelection?
    @FocusState private var focused: Bool
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("FIELD NOTES").font(.caption.weight(.semibold)).foregroundStyle(.secondary).padding(.horizontal, 24)
            TextEditor(text: $text, selection: $selection)
                .font(.body).scrollContentBackground(.hidden).contentMargins(.horizontal, 18)
                .focused($focused).accessibilityIdentifier("capture-focus")
            HStack {
                Text("\(text.split(whereSeparator: \.isWhitespace).count) words").foregroundStyle(.secondary)
                Spacer()
                Button("Select all") { focused = true; selection = TextSelection(range: text.startIndex..<text.endIndex) }
            }.font(.subheadline).padding(.horizontal, 24).padding(.bottom, 16)
        }
        .padding(.top, 20)
        .navigationTitle("A quieter day").navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItemGroup(placement: .keyboard) { Spacer(); Button("Done") { focused = false } } }
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focused = true } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { TextEditorSelectionDemo() } }
