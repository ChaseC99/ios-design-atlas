import SwiftUI

struct ListOutlineHierarchyDemo: View {
    private struct Folder: Identifiable {
        let id: String
        let symbol: String
        var children: [Folder]?
    }
    @State private var favoritesExpanded = true
    @State private var projectsExpanded = true
    private let folders = [
        Folder(id: "Travel", symbol: "map", children: [Folder(id: "Northern coast", symbol: "water.waves", children: [Folder(id: "Point Reyes", symbol: "mappin", children: nil), Folder(id: "Mendocino", symbol: "mappin", children: nil)]), Folder(id: "City weekends", symbol: "building.2", children: nil)]),
        Folder(id: "Creative work", symbol: "paintbrush", children: [Folder(id: "Sketchbook", symbol: "pencil", children: nil), Folder(id: "Words to keep", symbol: "quote.opening", children: nil)])
    ]
    var body: some View {
        List {
            Section {
                DisclosureGroup("Favorites", isExpanded: $favoritesExpanded) {
                    Label("Morning rituals", systemImage: "sun.horizon").foregroundStyle(.orange)
                    Label("A slower weekend", systemImage: "cup.and.saucer").foregroundStyle(.brown)
                }
                DisclosureGroup("Projects", isExpanded: $projectsExpanded) {
                    Label("An illustrated journal", systemImage: "book.pages")
                    Label("Places we call home", systemImage: "house")
                }
            }
            Section("All collections") {
                OutlineGroup(folders, children: \.children) { folder in
                    Label(folder.id, systemImage: folder.symbol).padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Library")
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ListOutlineHierarchyDemo() } }
