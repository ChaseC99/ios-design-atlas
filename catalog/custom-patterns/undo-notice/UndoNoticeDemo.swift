import SwiftUI

struct UndoNoticeDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOver
    @State private var items = ["A slower morning", "The coastal trail", "Reading room ideas"]
    @State private var removed: Removed?
    @State private var noticeID = UUID()
    var body: some View {
        List {
            Section("Saved for later") {
                ForEach(items, id: \.self) { title in
                    HStack(spacing: 16) {
                        Image(systemName: "bookmark").font(.title2).foregroundStyle(.teal)
                        Text(title).padding(.vertical, 16)
                        Spacer()
                        Button("Archive \(title)", systemImage: "archivebox") { archive(title) }.labelStyle(.iconOnly).buttonStyle(.borderless)
                    }
                }
            }
            if items.isEmpty { ContentUnavailableView("All caught up", systemImage: "checkmark.circle") }
        }
        .safeAreaInset(edge: .bottom) {
            if let removed {
                HStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.teal)
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Moved to archive").font(.headline)
                        Text(removed.title).font(.caption).foregroundStyle(.secondary).lineLimit(1)
                    }
                    Spacer()
                    Button("Undo") { undo() }.fontWeight(.semibold)
                    Button("Dismiss notice", systemImage: "xmark") { self.removed = nil }.labelStyle(.iconOnly)
                }.padding(20).background(.regularMaterial, in: .rect(cornerRadius: 24)).padding(16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .task(id: noticeID) {
            guard removed != nil, !capturing, !voiceOver else { return }
            try? await Task.sleep(for: .seconds(6))
            guard !Task.isCancelled else { return }
            withAnimation(reduceMotion ? nil : .snappy) { removed = nil }
        }
        .task { if capturing { archive("A slower morning") } }
        .navigationTitle("Reading list").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func archive(_ title: String) {
        guard let index = items.firstIndex(of: title) else { return }
        withAnimation(reduceMotion ? nil : .snappy) {
            removed = Removed(title: title, index: index); items.remove(at: index); noticeID = UUID()
        }
    }
    private func undo() {
        guard let removed else { return }
        withAnimation(reduceMotion ? nil : .snappy) {
            items.insert(removed.title, at: min(removed.index, items.count)); self.removed = nil
        }
    }
    private struct Removed { let title: String; let index: Int }
}
#Preview { NavigationStack { UndoNoticeDemo() } }
