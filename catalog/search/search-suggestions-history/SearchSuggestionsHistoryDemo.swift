import SwiftUI

struct SearchSuggestionsHistoryDemo: View {
    @State private var query = ""
    @State private var recent = ["Point Reyes", "Big Sur"]
    @State private var presented = false
    @FocusState private var focused: Bool
    private let places = ["Big Sur", "Carmel", "Mendocino", "Point Reyes", "Santa Cruz", "Sonoma"]
    var body: some View {
        List(places.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }, id: \.self) { place in
            Label(place, systemImage: "mappin.circle").padding(.vertical, 10)
        }
        .navigationTitle("Find your next place")
        .searchable(text: $query, isPresented: $presented, placement: .navigationBarDrawer(displayMode: .always), prompt: "Places and collections")
        .searchFocused($focused)
        .searchSuggestions {
            if query.isEmpty {
                Section("Recent") {
                    ForEach(recent, id: \.self) { Label($0, systemImage: "clock").searchCompletion($0) }
                }
                Section("Suggested") {
                    Label("Mendocino", systemImage: "sparkles").searchCompletion("Mendocino")
                    Label("Santa Cruz", systemImage: "sparkles").searchCompletion("Santa Cruz")
                }
            } else {
                ForEach(places.filter { $0.localizedCaseInsensitiveContains(query) && $0 != query }, id: \.self) {
                    Text($0).searchCompletion($0)
                }
            }
        }
        .onSubmit(of: .search) {
            let term = query.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !term.isEmpty else { return }
            recent.removeAll { $0.caseInsensitiveCompare(term) == .orderedSame }
            recent.insert(term, at: 0); recent = Array(recent.prefix(5)); focused = false
        }
        .task {
            if ProcessInfo.processInfo.arguments.contains("--capture") {
                try? await Task.sleep(for: .milliseconds(400)); presented = true; focused = true
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchSuggestionsHistoryDemo() } }
