import SwiftUI

struct KeyboardSafeAreasDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var draft = ""
    @State private var sent = ["Found a quiet little place by the water.", "That sounds like the perfect afternoon."]
    @FocusState private var focused: Bool
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        Text("TODAY · 9:41 AM").font(.caption2.weight(.medium)).foregroundStyle(.secondary)
                        ForEach(Array(sent.enumerated()), id: \.offset) { index, message in
                            HStack {
                                if index % 2 == 1 { Spacer(minLength: 44) }
                                Text(message).padding(18)
                                    .background(index % 2 == 1 ? Color.teal.opacity(0.18) : Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 22))
                                if index % 2 == 0 { Spacer(minLength: 44) }
                            }.id(index)
                        }
                    }.padding(24)
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: sent.count) { _, _ in withAnimation { proxy.scrollTo(sent.count - 1, anchor: .bottom) } }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            HStack(alignment: .bottom, spacing: 12) {
                TextField("Message", text: $draft, axis: .vertical)
                    .lineLimit(1...4).padding(12)
                    .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
                    .focused($focused)
                    .accessibilityIdentifier("capture-focus")
                Button("Send", systemImage: "arrow.up.circle.fill") { send() }
                    .font(.title).labelStyle(.iconOnly).tint(.teal)
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.bottom, 6)
            }.padding(.horizontal, 20).padding(.vertical, 12).background(.bar)
        }
        .navigationTitle("Alex").navigationBarTitleDisplayMode(.inline)
        .toolbar { if !capturing { ToolbarItem(placement: .keyboard) { Button("Done") { focused = false } } } }
        .accessibilityIdentifier("capture-ready")
    }
    private func send() {
        let message = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        sent.append(message); draft = ""
    }
}
#Preview { NavigationStack { KeyboardSafeAreasDemo() } }
