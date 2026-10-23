import SwiftUI

struct SearchResultStatesDemo: View {
    private enum Phase { case idle, loading, results, failed }
    @State private var query = ProcessInfo.processInfo.arguments.contains("--capture") ? "desert" : ""
    @State private var phase = Phase.idle
    @State private var simulateError = false
    @State private var retry = 0
    private let places = ["Big Sur", "Carmel", "Point Reyes", "Mendocino"]
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var results: [String] { places.filter { $0.localizedCaseInsensitiveContains(query) } }
    var body: some View {
        Group {
            switch phase {
            case .idle:
                ContentUnavailableView("Find somewhere new", systemImage: "magnifyingglass", description: Text("Search your saved places and collections."))
            case .loading:
                ProgressView("Searching places…").frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failed:
                ContentUnavailableView {
                    Label("Search unavailable", systemImage: "wifi.exclamationmark")
                } description: { Text("This example simulates a temporary error.") } actions: {
                    Button("Try Again") { simulateError = false; retry += 1 }.buttonStyle(.borderedProminent)
                }
            case .results:
                if results.isEmpty { ContentUnavailableView.search(text: query) }
                else { List(results, id: \.self) { Label($0, systemImage: "mappin.circle").padding(.vertical, 10) } }
            }
        }
        .navigationTitle("Search")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Places and collections")
        .toolbar {
            if !isCapturing { ToolbarItem(placement: .topBarTrailing) { Toggle("Simulate error", isOn: $simulateError) } }
        }
        .task(id: "\(query)|\(retry)|\(simulateError)") {
            guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { phase = .idle; return }
            phase = .loading
            do { try await Task.sleep(for: .milliseconds(650)) } catch { return }
            guard !Task.isCancelled else { return }
            phase = simulateError ? .failed : .results
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchResultStatesDemo() } }
