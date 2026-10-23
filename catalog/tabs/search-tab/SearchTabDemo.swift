import SwiftUI

struct SearchTabDemo: View {
    @State private var selection = 1
    @State private var query = ""
    private let places = ["Big Sur", "Carmel", "Point Reyes", "Mendocino", "Monterey", "Santa Cruz"]
    private var results: [String] { query.isEmpty ? places : places.filter { $0.localizedCaseInsensitiveContains(query) } }
    var body: some View {
        TabView(selection: $selection) {
            Tab("Explore", systemImage: "safari", value: 0) {
                NavigationStack {
                    ContentUnavailableView("Find your next favorite place", systemImage: "map", description: Text("Explore a little closer to home."))
                        .navigationTitle("Explore")
                }
            }
            Tab("Saved", systemImage: "bookmark", value: 2) {
                NavigationStack { ContentUnavailableView("Nothing saved yet", systemImage: "bookmark").navigationTitle("Saved") }
            }
            Tab("Search", systemImage: "magnifyingglass", value: 1, role: .search) {
                NavigationStack {
                    List {
                        Section(query.isEmpty ? "Places to explore" : "Results") {
                            ForEach(results, id: \.self) { place in
                                NavigationLink {
                                    ContentUnavailableView(place, systemImage: "mappin.and.ellipse", description: Text("A place worth making time for."))
                                } label: {
                                    Label(place, systemImage: "mappin.circle").padding(.vertical, 8)
                                }
                            }
                        }
                    }
                    .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
                    .navigationTitle("Search")
                }
                .searchable(text: $query, prompt: "Places and collections")
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { SearchTabDemo() }
