import SwiftUI

struct FloatingCreationTrayDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var expanded = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var items = [Note(id: 0, title: "Weekend thoughts", symbol: "note.text"), Note(id: 1, title: "Places to go", symbol: "checklist")]
    @State private var nextID = 2
    var body: some View {
        List {
            Section {
                ForEach(items) { note in
                    Label { Text(note.title).padding(.vertical, 18) } icon: {
                        Image(systemName: note.symbol).font(.title2).foregroundStyle(.teal).frame(width: 42)
                    }
                }.onDelete { items.remove(atOffsets: $0) }
            } header: { Text("Your notebook") }
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            VStack(alignment: .trailing, spacing: 14) {
                if expanded {
                    VStack(alignment: .leading, spacing: 4) {
                        action("New note", symbol: "note.text", type: "Note")
                        action("New checklist", symbol: "checklist", type: "Checklist")
                        action("New sketch", symbol: "pencil.tip", type: "Sketch")
                    }
                    .padding(12).background(.regularMaterial, in: .rect(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.06), radius: 20, y: 8)
                    .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .bottomTrailing)))
                }
                Button {
                    withAnimation(reduceMotion ? nil : .snappy) { expanded.toggle() }
                } label: {
                    Image(systemName: "plus").font(.title2.weight(.semibold))
                        .rotationEffect(.degrees(expanded ? 45 : 0))
                        .frame(width: 64, height: 64).foregroundStyle(.white).background(.teal, in: Circle())
                }.accessibilityLabel(expanded ? "Close creation tray" : "Create item")
            }.padding(24)
        }
        .navigationTitle("Notebook").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func action(_ title: String, symbol: String, type: String) -> some View {
        Button {
            withAnimation(reduceMotion ? nil : .snappy) {
                items.insert(Note(id: nextID, title: "\(type) \(nextID + 1)", symbol: symbol), at: 0)
                nextID += 1; expanded = false
            }
        } label: { Label(title, systemImage: symbol).frame(maxWidth: .infinity, alignment: .leading).padding(14).contentShape(Rectangle()) }
            .buttonStyle(.plain).frame(width: 220)
    }
    private struct Note: Identifiable { let id: Int; let title: String; let symbol: String }
}
#Preview { NavigationStack { FloatingCreationTrayDemo() } }
