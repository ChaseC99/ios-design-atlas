import SwiftUI

struct FilterSortSheetFlowDemo: View {
    private struct Place: Identifiable {
        let id: String
        let region: String
        let minutes: Int
        let saved: Bool
    }
    private struct Filters: Equatable {
        var region = "All places"
        var savedOnly = false
        var sort = "Nearest first"
    }
    @State private var filters = Filters()
    @State private var draft = Filters()
    @State private var presented = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private let places = [Place(id: "North Beach", region: "Coast", minutes: 12, saved: true), Place(id: "Fern Grove", region: "Forest", minutes: 24, saved: false), Place(id: "Cypress Point", region: "Coast", minutes: 18, saved: true), Place(id: "Redwood Loop", region: "Forest", minutes: 36, saved: true)]
    private func matches(_ filters: Filters) -> [Place] {
        places.filter { (filters.region == "All places" || $0.region == filters.region) && (!filters.savedOnly || $0.saved) }
            .sorted { filters.sort == "Nearest first" ? $0.minutes < $1.minutes : $0.id < $1.id }
    }
    var body: some View {
        List(matches(filters)) { place in
            HStack {
                Image(systemName: place.region == "Coast" ? "water.waves" : "tree").foregroundStyle(.teal).frame(width: 28)
                VStack(alignment: .leading, spacing: 4) { Text(place.id).font(.headline); Text("\(place.region) · \(place.minutes) min away").font(.subheadline).foregroundStyle(.secondary) }
                Spacer()
                if place.saved { Image(systemName: "bookmark.fill").foregroundStyle(.teal) }
            }.padding(.vertical, 6)
        }
        .overlay { if matches(filters).isEmpty { ContentUnavailableView.search } }
        .toolbar { Button("Filter", systemImage: "line.3.horizontal.decrease") { draft = filters; presented = true } }
        .sheet(isPresented: $presented) {
            NavigationStack {
                Form {
                    Section("Places") {
                        Picker("Region", selection: $draft.region) { Text("All places").tag("All places"); Text("Coast").tag("Coast"); Text("Forest").tag("Forest") }
                        Toggle("Saved places only", isOn: $draft.savedOnly)
                    }
                    Section("Order") { Picker("Sort", selection: $draft.sort) { Text("Nearest first").tag("Nearest first"); Text("Name").tag("Name") } }
                    Section { Button("Reset filters") { draft = Filters() } }
                }
                .safeAreaInset(edge: .bottom) {
                    Button("Show \(matches(draft).count) places") { filters = draft; presented = false }
                        .buttonStyle(.borderedProminent).controlSize(.large).frame(maxWidth: .infinity).padding().background(.bar)
                }
                .navigationTitle("Filter places").navigationBarTitleDisplayMode(.inline)
                .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { presented = false } } }
                .accessibilityIdentifier("capture-ready")
            }.presentationDetents([.medium, .large]).presentationDragIndicator(.visible)
        }
        .onAppear { if isCapturing { draft.region = "Coast"; draft.savedOnly = true; presented = true } }
        .navigationTitle("Nearby places")
    }
}

#Preview { NavigationStack { FilterSortSheetFlowDemo() } }
