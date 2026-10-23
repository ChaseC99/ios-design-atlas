import SwiftUI

struct EmptyUnavailableDemo: View {
    private enum Scenario: String, CaseIterable { case firstUse = "First use", collection = "Collection", search = "Search", unavailable = "Unavailable" }
    @State private var scenario = Scenario.firstUse
    @State private var places: [String] = []
    @State private var query = "Sunrise"
    @State private var restored = false
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch scenario {
                case .firstUse, .collection:
                    if places.isEmpty {
                        ContentUnavailableView {
                            Label(scenario == .firstUse ? "Your places start here" : "No saved places", systemImage: scenario == .firstUse ? "bookmark" : "tray")
                        } description: {
                            Text(scenario == .firstUse ? "Keep the places you want to return to." : "Add a place to this collection.")
                        } actions: {
                            Button("Add a sample place") { places = ["Harbor walk", "Forest trail"] }.buttonStyle(.borderedProminent)
                        }
                    } else { placesList }
                case .search:
                    if query.isEmpty { placesList }
                    else { ContentUnavailableView.search(text: query) }
                case .unavailable:
                    if restored { placesList }
                    else {
                        ContentUnavailableView {
                            Label("Collection unavailable", systemImage: "folder.badge.questionmark")
                        } description: {
                            Text("This sample collection needs to be restored before it can open.")
                        } actions: {
                            Button("Restore sample") { restored = true; places = ["Harbor walk", "Forest trail"] }.buttonStyle(.borderedProminent)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            Form {
                Picker("Scenario", selection: $scenario) { ForEach(Scenario.allCases, id: \.self) { Text($0.rawValue).tag($0) } }
                if scenario == .search {
                    Button("Clear search") { query = ""; places = ["Harbor walk", "Forest trail"] }.disabled(query.isEmpty)
                }
                Button("Reset sample") { places = []; query = "Sunrise"; restored = false }
            }.frame(height: scenario == .search ? 220 : 170)
        }
        .navigationTitle("Empty and unavailable").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var placesList: some View {
        List(places, id: \.self) { Label($0, systemImage: "mappin.and.ellipse") }
    }
}

#Preview { NavigationStack { EmptyUnavailableDemo() } }
