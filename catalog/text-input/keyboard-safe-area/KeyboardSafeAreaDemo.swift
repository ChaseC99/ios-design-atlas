import SwiftUI

struct KeyboardSafeAreaDemo: View {
    @State private var draft = "That sounds like a perfect afternoon."
    @State private var messages = ["Let's take the coastal path this weekend.", "Good idea. There is a little café near the trailhead.", "A walk, a coffee, and no particular schedule."]
    @FocusState private var focused: Bool
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 18) {
                    Text("TODAY · 9:41 AM").font(.caption2.weight(.medium)).foregroundStyle(.secondary).padding(.top, 12)
                    ForEach(messages.indices, id: \.self) { index in
                        HStack {
                            if index.isMultiple(of: 2) { Spacer(minLength: 40) }
                            Text(messages[index]).padding(16)
                                .foregroundStyle(index.isMultiple(of: 2) ? Color.white : .primary)
                                .background(index.isMultiple(of: 2) ? Color.indigo : Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 20))
                            if !index.isMultiple(of: 2) { Spacer(minLength: 40) }
                        }.id(index)
                    }
                }.padding(20)
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: messages.count) { _, _ in withAnimation { proxy.scrollTo(messages.count - 1, anchor: .bottom) } }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(alignment: .bottom, spacing: 12) {
                TextField("Message", text: $draft, axis: .vertical).lineLimit(1...4)
                    .padding(.horizontal, 14).padding(.vertical, 11)
                    .background(Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 22))
                    .focused($focused).accessibilityIdentifier("capture-focus")
                Button("Send", systemImage: "arrow.up.circle.fill") { send() }
                    .font(.system(size: 34)).labelStyle(.iconOnly)
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .keyboardShortcut(.return, modifiers: .command)
            }.padding(.horizontal, 16).padding(.vertical, 10).background(.bar)
        }
        .navigationTitle("Weekend plans").navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focused = true } }
        .accessibilityIdentifier("capture-ready")
    }
    private func send() {
        let message = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        messages.append(message); draft = ""
    }
}

#Preview { NavigationStack { KeyboardSafeAreaDemo() } }
