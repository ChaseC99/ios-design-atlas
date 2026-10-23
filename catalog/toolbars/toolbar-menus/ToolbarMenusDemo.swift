import SwiftUI

struct ToolbarMenusDemo: View {
    @State private var sort = "Name"
    @State private var ascending = true
    @State private var showFavorites = false
    @State private var items = ["Coastal walks", "Quiet mornings", "City details", "Sunday sketches"]
    private var visible: [String] {
        let filtered = showFavorites ? items.filter { $0.contains("Quiet") || $0.contains("Coastal") } : items
        let sorted = sort == "Name" ? filtered.sorted() : filtered
        return ascending ? sorted : sorted.reversed()
    }
    var body: some View {
        List {
            Section {
                ForEach(visible, id: \.self) { name in
                    Label { VStack(alignment: .leading, spacing: 6) {
                        Text(name).font(.headline)
                        Text("A collection of small things").font(.subheadline).foregroundStyle(.secondary)
                    }} icon: {
                        Image(systemName: "folder").font(.title2).foregroundStyle(.orange).frame(width: 38)
                    }.padding(.vertical, 12)
                }
            } header: { Text(showFavorites ? "Favorites" : "Your collections") }
        }
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("New collection", systemImage: "folder.badge.plus") { items.append("New collection \(items.count + 1)") }
                    Section {
                        Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                            Picker("Order", selection: $sort) { Text("Name").tag("Name"); Text("Added").tag("Added") }
                            Toggle("Ascending", isOn: $ascending)
                        }
                        Toggle("Favorites only", systemImage: "star", isOn: $showFavorites)
                    }
                    Section {
                        Button("Reset collections", systemImage: "arrow.counterclockwise") {
                            items = ["Coastal walks", "Quiet mornings", "City details", "Sunday sketches"]
                        }
                    }
                } label: { Label("Collection actions", systemImage: "ellipsis") }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ToolbarMenusDemo() } }
