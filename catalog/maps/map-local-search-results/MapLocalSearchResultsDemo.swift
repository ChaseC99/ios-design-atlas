import SwiftUI
import MapKit

struct MapLocalSearchResultsDemo: View {
    @State private var query = ""
    @State private var selected: Int? = 0
    @State private var position = MapCameraPosition.region(Self.region)
    private static let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.802, longitude: -122.459), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04))
    private let samples = [Place(id: 0, name: "Lookout", type: "Views", symbol: "binoculars", latitude: 37.8064, longitude: -122.4702), Place(id: 1, name: "Garden", type: "Nature", symbol: "leaf", latitude: 37.7995, longitude: -122.4598), Place(id: 2, name: "Coffee stop", type: "Refreshments", symbol: "cup.and.saucer", latitude: 37.8014, longitude: -122.4468)]
    private var results: [Place] { samples.filter { query.isEmpty || $0.name.localizedCaseInsensitiveContains(query) || $0.type.localizedCaseInsensitiveContains(query) } }
    var body: some View {
        VStack(spacing: 0) {
            Map(position: $position, selection: $selected) {
                ForEach(results) { place in Marker(place.name, systemImage: place.symbol, coordinate: place.coordinate).tint(.teal).tag(place.id) }
            }.frame(minHeight: 260, maxHeight: .infinity)
            if results.isEmpty { ContentUnavailableView.search(text: query).frame(maxHeight: 240) }
            else {
                List(results) { place in
                    Button { selected = place.id; withAnimation { position = .region(MKCoordinateRegion(center: place.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.016, longitudeDelta: 0.022))) } } label: {
                        HStack(spacing: 16) {
                            Image(systemName: place.symbol).font(.title2).foregroundStyle(.teal).frame(width: 34)
                            VStack(alignment: .leading, spacing: 5) { Text(place.name).foregroundStyle(.primary); Text("\(place.type) · Sample place").font(.caption).foregroundStyle(.secondary) }
                            Spacer()
                            if selected == place.id { Image(systemName: "checkmark").foregroundStyle(.teal) }
                        }.padding(.vertical, 8)
                    }
                }.listStyle(.plain).frame(height: CGFloat(results.count) * 78)
            }
        }
        .searchable(text: $query, prompt: "Filter sample places")
        .onChange(of: query) { _, _ in if !results.contains(where: { $0.id == selected }) { selected = nil } }
        .navigationTitle("Places to pause").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct Place: Identifiable {
        let id: Int; let name: String; let type: String; let symbol: String; let latitude: Double; let longitude: Double
        var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    }
}
#Preview { NavigationStack { MapLocalSearchResultsDemo() } }
