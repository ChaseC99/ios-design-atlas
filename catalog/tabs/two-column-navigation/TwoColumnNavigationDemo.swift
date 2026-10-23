import SwiftUI

struct TwoColumnNavigationDemo: View {
    @State private var selection: String?
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var compactColumn: NavigationSplitViewColumn = .sidebar
    private let collections = ["Coastal walks", "City weekends", "Mountain escapes"]
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility, preferredCompactColumn: $compactColumn) {
            List(collections, id: \.self, selection: $selection) { collection in
                NavigationLink(value: collection) {
                    Label(collection, systemImage: collection == "Coastal walks" ? "water.waves" : collection == "City weekends" ? "building.2" : "mountain.2")
                        .padding(.vertical, 10)
                }
            }
            .navigationTitle("Journeys")
            .navigationSplitViewColumnWidth(min: 240, ideal: 300, max: 360)
        } detail: {
            if let selection {
                VStack(alignment: .leading, spacing: 24) {
                    Image(systemName: "map.fill").font(.system(size: 70)).foregroundStyle(.teal)
                    Text(selection).font(.largeTitle.bold())
                    Text("An open invitation to take the long way home.").font(.title3).foregroundStyle(.secondary)
                    Button("Clear selection") { self.selection = nil; compactColumn = .sidebar }
                        .buttonStyle(.bordered)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(32)
                    .navigationTitle(selection).navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Choose a collection", systemImage: "sidebar.left", description: Text("Your next journey starts in the sidebar."))
            }
        }
        .navigationSplitViewStyle(.balanced)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { TwoColumnNavigationDemo() }
