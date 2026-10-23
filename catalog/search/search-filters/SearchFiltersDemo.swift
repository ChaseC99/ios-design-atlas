import SwiftUI

struct SearchFiltersDemo: View {
    private struct Place: Identifiable { let id: String; let coast: Bool; let favorite: Bool }
    @State private var query = ""
    @State private var coastOnly = true
    @State private var favoritesOnly = false
    @State private var ascending = true
    @State private var showFilters = false
    private let places = [Place(id: "Point Reyes", coast: true, favorite: true), Place(id: "Mendocino", coast: true, favorite: false), Place(id: "Santa Cruz", coast: true, favorite: true), Place(id: "Sonoma", coast: false, favorite: true)]
    private var results: [Place] {
        places.filter { (!coastOnly || $0.coast) && (!favoritesOnly || $0.favorite) && (query.isEmpty || $0.id.localizedCaseInsensitiveContains(query)) }
            .sorted { ascending ? $0.id < $1.id : $0.id > $1.id }
    }
    var body: some View {
        List {
            if coastOnly || favoritesOnly {
                Section {
                    HStack {
                        if coastOnly { Button("Coast ×") { coastOnly = false }.buttonStyle(.bordered) }
                        if favoritesOnly { Button("Favorites ×") { favoritesOnly = false }.buttonStyle(.bordered) }
                    }
                }
            }
            Section("\(results.count) places") {
                ForEach(results) { place in
                    HStack {
                        Label(place.id, systemImage: place.coast ? "water.waves" : "leaf")
                        Spacer()
                        if place.favorite { Image(systemName: "star.fill").foregroundStyle(.orange) }
                    }.padding(.vertical, 12)
                }
            }
        }
        .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
        .navigationTitle("Explore")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Find a place")
        .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Filters", systemImage: "line.3.horizontal.decrease") { showFilters = true } } }
        .sheet(isPresented: $showFilters) {
            NavigationStack {
                Form {
                    Section("Show") { Toggle("Coastal places", isOn: $coastOnly); Toggle("Favorites only", isOn: $favoritesOnly) }
                    Picker("Sort", selection: $ascending) { Text("A–Z").tag(true); Text("Z–A").tag(false) }
                    Button("Reset filters") { coastOnly = false; favoritesOnly = false; ascending = true }
                }.navigationTitle("Filters").navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { showFilters = false } } }
            }.presentationDetents([.medium, .large])
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchFiltersDemo() } }
