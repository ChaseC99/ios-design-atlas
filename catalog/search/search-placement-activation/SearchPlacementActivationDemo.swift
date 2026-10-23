import SwiftUI

struct SearchPlacementActivationDemo: View {
    @State private var query = ""
    @State private var presented = false
    @State private var alwaysVisible = true
    @FocusState private var focused: Bool
    private let places = ["Big Sur", "Carmel", "Mendocino", "Point Reyes", "Santa Cruz", "Sonoma"]
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        List {
            if !isCapturing {
                Section {
                    Toggle("Always show search field", isOn: $alwaysVisible)
                    Button("Begin searching", systemImage: "magnifyingglass") { presented = true; focused = true }
                }
            }
            Section("Places to explore") {
                ForEach(places.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }, id: \.self) { place in
                    Label(place, systemImage: "mappin.and.ellipse").padding(.vertical, 10)
                }
            }
        }
        .navigationTitle("Explore")
        .searchable(text: $query, isPresented: $presented, placement: .navigationBarDrawer(displayMode: alwaysVisible ? .always : .automatic), prompt: "Find a place")
        .searchFocused($focused)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SearchPlacementActivationDemo() } }
