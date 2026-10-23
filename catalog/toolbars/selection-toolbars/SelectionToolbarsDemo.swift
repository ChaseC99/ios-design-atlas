import SwiftUI

struct SelectionToolbarsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var selected: Set<String> = []
    @State private var items = ["Morning light", "Coastline", "Small details", "After the rain", "Blue hour", "Summer shade"]
    @State private var favorites: Set<String> = []
    @State private var editMode = EditMode.active
    var body: some View {
        List(items, id: \.self, selection: $selected) { name in
            HStack(spacing: 18) {
                RoundedRectangle(cornerRadius: 12).fill(.teal.gradient).frame(width: 48, height: 48)
                    .overlay(Image(systemName: "leaf").foregroundStyle(.white))
                Text(name).font(.headline)
                Spacer()
                if favorites.contains(name) { Image(systemName: "star.fill").foregroundStyle(.orange) }
            }.padding(.vertical, 6)
        }
        .environment(\.editMode, $editMode)
        .navigationTitle(selected.isEmpty ? "Select studies" : "\(selected.count) selected")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(selected.count == items.count ? "Deselect all" : "Select all") {
                    selected = selected.count == items.count ? [] : Set(items)
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Favorite", systemImage: "star") { favorites.formUnion(selected); selected.removeAll() }.disabled(selected.isEmpty)
                Spacer()
                Button("Delete", systemImage: "trash", role: .destructive) {
                    items.removeAll { selected.contains($0) }; selected.removeAll()
                }.disabled(selected.isEmpty)
            }
        }
        .task { if capturing { selected = ["Morning light", "Coastline"] } }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { SelectionToolbarsDemo() } }
