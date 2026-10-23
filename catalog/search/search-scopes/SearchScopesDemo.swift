import SwiftUI

struct SearchScopesDemo: View {
    private enum Scope: String, CaseIterable { case all = "All", places = "Places", notes = "Notes" }
    @State private var scope = Scope.all
    @State private var query = "coast"
    @State private var presented = false
    @FocusState private var focused: Bool
    private let items: [(String, Scope)] = [("Northern coast", .places), ("A weekend on the coast", .notes), ("Coastal path", .places), ("Coastline field notes", .notes), ("Morning in the city", .notes)]
    private var results: [(String, Scope)] { items.filter { (scope == .all || scope == $0.1) && (query.isEmpty || $0.0.localizedCaseInsensitiveContains(query)) } }
    var body: some View {
        List(results, id: \.0) { title, type in
            VStack(alignment: .leading, spacing: 7) {
                Label(title, systemImage: type == .places ? "mappin.circle" : "note.text").font(.headline)
                Text(type.rawValue).font(.caption).foregroundStyle(.secondary)
            }.padding(.vertical, 9)
        }
        .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
        .navigationTitle("Search the library")
        .searchable(text: $query, isPresented: $presented, placement: .navigationBarDrawer(displayMode: .always))
        .searchFocused($focused)
        .searchScopes($scope, activation: .onSearchPresentation) {
            ForEach(Scope.allCases, id: \.self) { Text($0.rawValue).tag($0) }
        }
        .task {
            if ProcessInfo.processInfo.arguments.contains("--capture") {
                try? await Task.sleep(for: .milliseconds(400)); presented = true; focused = true
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchScopesDemo() } }
