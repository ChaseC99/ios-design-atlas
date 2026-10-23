import SwiftUI

struct SearchTokensDemo: View {
    private struct Token: Identifiable, Hashable { let id: String; let symbol: String }
    @State private var query = ""
    @State private var tokens = [Token(id: "Coast", symbol: "water.waves")]
    @State private var suggested = [Token(id: "Quiet", symbol: "leaf"), Token(id: "Walks", symbol: "figure.walk")]
    @State private var presented = false
    @FocusState private var focused: Bool
    private let places: [(String, Set<String>)] = [("Point Reyes", ["Coast", "Quiet", "Walks"]), ("Santa Cruz", ["Coast", "Walks"]), ("Mendocino", ["Coast", "Quiet"]), ("Sonoma", ["Quiet", "Walks"])]
    private var results: [(String, Set<String>)] { places.filter { place in tokens.allSatisfy { place.1.contains($0.id) } && (query.isEmpty || place.0.localizedCaseInsensitiveContains(query)) } }
    var body: some View {
        List(results, id: \.0) { name, tags in
            VStack(alignment: .leading, spacing: 6) {
                Text(name).font(.headline)
                Text(tags.sorted().joined(separator: " · ")).font(.caption).foregroundStyle(.secondary)
            }.padding(.vertical, 9)
        }
        .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
        .navigationTitle("Places")
        .searchable(text: $query, tokens: $tokens, suggestedTokens: $suggested, isPresented: $presented, placement: .navigationBarDrawer(displayMode: .always), prompt: "Places and tags") { token in
            Label(token.id, systemImage: token.symbol)
        }
        .searchFocused($focused)
        .task {
            if ProcessInfo.processInfo.arguments.contains("--capture") {
                try? await Task.sleep(for: .milliseconds(400)); presented = true; focused = true
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchTokensDemo() } }
