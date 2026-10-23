import SwiftUI

@available(iOS 26.0, *)
struct ListSectionIndexDemo: View {
    private let groups: [(String, [String])] = [
        ("A", ["Acadia", "Alameda", "Astoria"]), ("B", ["Bend", "Berkeley", "Big Sur"]),
        ("C", ["Cambria", "Carmel", "Cayucos"]), ("D", ["Davenport", "Davis", "Dunsmuir"]),
        ("E", ["Elk", "Encinitas", "Eureka"]), ("F", ["Fairfax", "Ferndale", "Fort Bragg"]),
        ("G", ["Glen Ellen", "Gualala", "Guerneville"]), ("H", ["Half Moon Bay", "Healdsburg", "Hood River"]),
        ("I", ["Idyllwild", "Inverness"]), ("J", ["Jackson", "Jenner", "Joshua Tree"]),
        ("L", ["Laguna Beach", "Lake Arrowhead", "Los Olivos"]), ("M", ["Mendocino", "Mill Valley", "Monterey"]),
        ("N", ["Napa", "Nevada City"]), ("O", ["Ojai", "Olympia"]), ("P", ["Pacific Grove", "Point Reyes"]),
        ("S", ["Santa Cruz", "Sausalito", "Sonoma"]), ("T", ["Tahoe City", "Trinidad"])
    ]
    var body: some View {
        List {
            ForEach(groups, id: \.0) { letter, places in
                Section(letter) {
                    ForEach(places, id: \.self) { place in
                        Text(place).padding(.vertical, 5)
                    }
                }.sectionIndexLabel(letter)
            }
        }
        .listStyle(.plain)
        .listSectionIndexVisibility(.visible)
        .navigationTitle("Places")
        .accessibilityIdentifier("capture-ready")
    }
}

@available(iOS 26.0, *)
#Preview { NavigationStack { ListSectionIndexDemo() } }
