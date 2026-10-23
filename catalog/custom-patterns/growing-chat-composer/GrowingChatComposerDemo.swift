import SwiftUI

struct GrowingChatComposerDemo: View {
    @State private var draft = "I’ll bring the notebook."
    @State private var messages = [Message(id: 0, text: "Shall we take the coastal path tomorrow?", mine: false), Message(id: 1, text: "Yes. Let’s leave a little time for the lookout.", mine: true), Message(id: 2, text: "Perfect. Coffee first?", mine: false)]
    @FocusState private var focused: Bool
    private var canSend: Bool { !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                LazyVStack(spacing: 20) {
                    Text("Saturday plans").font(.caption).foregroundStyle(.secondary).padding(.vertical, 16)
                    ForEach(messages) { message in
                        HStack {
                            if message.mine { Spacer(minLength: 45) }
                            Text(message.text).padding(.horizontal, 18).padding(.vertical, 14)
                                .foregroundStyle(message.mine ? .white : .primary)
                                .background(message.mine ? Color.teal : Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 23))
                                .accessibilityLabel(message.mine ? "You: \(message.text)" : "Avery: \(message.text)")
                            if !message.mine { Spacer(minLength: 45) }
                        }.id(message.id)
                    }
                }.padding(20).frame(maxWidth: 760).frame(maxWidth: .infinity)
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: messages.count) { _, _ in if let last = messages.last { withAnimation { reader.scrollTo(last.id, anchor: .bottom) } } }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .bottom, spacing: 12) {
                    Menu {
                        Button("Suggest a time") { draft = "Shall we meet at nine?" }
                        Button("Suggest coffee") { draft = "Let’s start with a coffee." }
                    } label: { Label("Message suggestions", systemImage: "plus.circle").labelStyle(.iconOnly).font(.title2).frame(width: 36, height: 44) }
                    TextField("Message", text: $draft, axis: .vertical).lineLimit(1...5).focused($focused)
                        .padding(.horizontal, 16).padding(.vertical, 12)
                        .background(Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 24))
                    Button("Send message", systemImage: "arrow.up.circle.fill") { send() }
                        .labelStyle(.iconOnly).font(.system(size: 34)).disabled(!canSend).frame(height: 44)
                }
            }.padding(14).background(.bar)
        }
        .navigationTitle("Avery").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func send() {
        guard canSend else { return }
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        messages.append(Message(id: (messages.last?.id ?? 0) + 1, text: text, mine: true))
        draft = ""
    }
    private struct Message: Identifiable { let id: Int; let text: String; let mine: Bool }
}
#Preview { NavigationStack { GrowingChatComposerDemo() } }
