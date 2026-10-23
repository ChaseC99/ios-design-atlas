import SwiftUI

struct BottomAnchoredChatDemo: View {
    @State private var messages = ["Made it to the coast.", "How is the weather?", "A little cloudy. The water is beautiful.", "Save a photo for me.", "Better yet, come next time."]
    @State private var draft = ""
    @FocusState private var focused: Bool
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("TODAY · 9:41 AM").font(.caption2).foregroundStyle(.secondary)
                    ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                        HStack {
                            if index % 2 == 0 { Spacer(minLength: 60) }
                            Text(message).padding(18)
                                .background(index % 2 == 0 ? Color.teal.opacity(0.17) : Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 24))
                            if index % 2 == 1 { Spacer(minLength: 60) }
                        }.id(index)
                    }
                }.padding(24)
            }
            .defaultScrollAnchor(.bottom)
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: messages.count) { _, _ in
                withAnimation { proxy.scrollTo(messages.count - 1, anchor: .bottom) }
            }
            .safeAreaInset(edge: .bottom) {
                HStack(alignment: .bottom) {
                    TextField("Message", text: $draft, axis: .vertical).lineLimit(1...4)
                        .focused($focused).textFieldStyle(.roundedBorder)
                    Button("Send", systemImage: "arrow.up.circle.fill") {
                        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !text.isEmpty else { return }
                        messages.append(text); draft = ""
                    }.font(.title).labelStyle(.iconOnly).disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }.padding().background(.bar)
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Sam").navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .keyboard) { Button("Done") { focused = false } } }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { BottomAnchoredChatDemo() } }
