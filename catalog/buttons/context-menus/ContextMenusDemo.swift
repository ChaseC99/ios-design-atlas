import SwiftUI

struct ContextMenusDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var mode = "Preview"
    @State private var favorite = false
    @State private var copies = 0
    @State private var items = ["Morning light", "Harbor walk", "Cypress grove"]
    @State private var selection: Set<String> = ["Morning light", "Harbor walk"]
    @State private var favorites: Set<String> = []

    var body: some View {
        VStack(spacing: 24) {
            if !isCapturing {
                Picker("Context", selection: $mode) {
                    Text("Preview").tag("Preview")
                    Text("Selection").tag("Selection")
                }.pickerStyle(.segmented).padding(.horizontal, 24)
            }
            if mode == "Selection" {
                List(items, id: \.self, selection: $selection) { item in
                    Label(item, systemImage: favorites.contains(item) ? "star.fill" : "photo")
                }
                .environment(\.editMode, .constant(.active))
                .contextMenu(forSelectionType: String.self) { targeted in
                    if targeted.isEmpty {
                        Button("Select all") { selection = Set(items) }
                    } else {
                        Button("Favorite \(targeted.count) items") { favorites.formUnion(targeted) }
                        Button("Delete selected", role: .destructive) {
                            items.removeAll { targeted.contains($0) }
                            selection.subtract(targeted)
                        }
                    }
                }
            } else {
                Spacer()
                artwork
                    .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 28))
                    .contextMenu {
                        Button(favorite ? "Remove from Favorites" : "Add to Favorites", systemImage: "star") { favorite.toggle() }
                            .accessibilityIdentifier("capture-ready")
                        Button("Make a copy", systemImage: "doc.on.doc") { copies += 1 }
                    } preview: {
                        artwork.frame(width: 300).padding(20)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier("capture-open")
                if !isCapturing {
                    Text(favorite ? "Favorite reference" : "Press and hold the reference").foregroundStyle(.secondary)
                    if copies > 0 { Text("\(copies) copies created").font(.caption) }
                }
                Spacer()
            }
        }
        .padding(.vertical, 24).frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Context menus and selection")
    }

    private var artwork: some View {
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "sun.horizon.fill").font(.system(size: 72)).foregroundStyle(.orange)
            Text("Morning light").font(.title2.bold())
            Text("A quiet walk by the harbor.").foregroundStyle(.secondary)
        }
        .padding(28).frame(maxWidth: 340, alignment: .leading)
        .background(.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 28))
    }
}

#Preview { NavigationStack { ContextMenusDemo() } }
