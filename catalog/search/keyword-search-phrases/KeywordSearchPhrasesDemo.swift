import SwiftUI

struct KeywordSearchPhrasesDemo: View {
    private struct Place: Identifiable { let id: String; let tags: Set<String>; let symbol: String }
    @State private var query = "quiet places near water"
    private let places = [
        Place(id: "Coastal garden", tags: ["quiet", "water", "outdoors"], symbol: "leaf"),
        Place(id: "Harbor walk", tags: ["quiet", "water", "outdoors"], symbol: "water.waves"),
        Place(id: "The courtyard café", tags: ["coffee", "outdoors"], symbol: "cup.and.saucer"),
        Place(id: "Neighborhood bookshop", tags: ["quiet", "books"], symbol: "books.vertical")
    ]
    private var filters: Set<String> {
        var values: Set<String> = []
        for tag in ["quiet", "water", "outdoors", "coffee", "books"] { if query.localizedCaseInsensitiveContains(tag) { values.insert(tag) } }
        if query.localizedCaseInsensitiveContains("coast") { values.insert("water") }
        if query.localizedCaseInsensitiveContains("outside") { values.insert("outdoors") }
        return values
    }
    private var results: [Place] {
        places.filter { query.isEmpty || (!filters.isEmpty && filters.isSubset(of: $0.tags)) || $0.id.localizedCaseInsensitiveContains(query) }
    }
    var body: some View {
        List {
            if !filters.isEmpty {
                Section { Text(filters.sorted().joined(separator: " · ")).font(.subheadline).foregroundStyle(.secondary) }
            }
            Section("Places") {
                ForEach(results) { place in
                    HStack(spacing: 14) {
                        Image(systemName: place.symbol).font(.title2).foregroundStyle(.teal)
                            .frame(width: 50, height: 50).background(.teal.opacity(0.1), in: .rect(cornerRadius: 14))
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.id).font(.headline)
                            Text(place.tags.sorted().joined(separator: " · ")).font(.caption).foregroundStyle(.secondary)
                        }
                    }.padding(.vertical, 10)
                }
            }
        }
        .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
        .navigationTitle("A place for today")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "What are you in the mood for?")
        .searchSuggestions {
            Text("Quiet places near water").searchCompletion("quiet places near water")
            Text("Coffee outside").searchCompletion("coffee outside")
            Text("Somewhere with books").searchCompletion("books")
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { KeywordSearchPhrasesDemo() } }
