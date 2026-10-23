import SwiftUI

struct SearchNavigationStateDemo: View {
    @State private var query = "coast"
    @State private var collection = "All collections"
    private let entries: [(String, String)] = [("Coastal mornings", "Personal"), ("Northern coast guide", "Travel"), ("A coast-to-coast itinerary", "Travel"), ("The garden notebook", "Personal")]
    private var results: [(String, String)] { entries.filter { (collection == "All collections" || $0.1 == collection) && (query.isEmpty || $0.0.localizedCaseInsensitiveContains(query)) } }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Collection", selection: $collection) {
                        Text("All collections").tag("All collections"); Text("Personal").tag("Personal"); Text("Travel").tag("Travel")
                    }
                }
                Section("Results") {
                    ForEach(results, id: \.0) { title, category in
                        NavigationLink(value: title) {
                            VStack(alignment: .leading, spacing: 7) {
                                Text(title).font(.headline)
                                Text(category).font(.caption).foregroundStyle(.secondary)
                            }.padding(.vertical, 9)
                        }
                    }
                }
            }
            .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
            .navigationTitle("Find a note")
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(for: String.self) { title in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(title).font(.system(.largeTitle, design: .serif).bold())
                        Text("Keep a little space for the familiar places that still have something new to show you.").font(.title3)
                    }.padding(28)
                }.navigationTitle("Note").navigationBarTitleDisplayMode(.inline)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { SearchNavigationStateDemo() }
