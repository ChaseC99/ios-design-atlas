import SwiftUI
import MapKit

struct MapPlaceSelectionDemo: View {
    @State private var selected: Int? = 0
    private let places = [Place(id: 0, title: "Morning viewpoint", symbol: "sun.horizon", latitude: 37.8064, longitude: -122.4702), Place(id: 1, title: "Garden pause", symbol: "leaf", latitude: 37.7995, longitude: -122.4598), Place(id: 2, title: "Afternoon stop", symbol: "cup.and.saucer", latitude: 37.8014, longitude: -122.4468)]
    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.803, longitude: -122.458), span: MKCoordinateSpan(latitudeDelta: 0.028, longitudeDelta: 0.038))), selection: $selected) {
            ForEach(places) { place in
                Marker(place.title, systemImage: place.symbol, coordinate: place.coordinate)
                    .tint(selected == place.id ? .orange : .teal).tag(place.id)
            }
        }
        .mapControls { MapCompass(); MapScaleView() }
        .safeAreaInset(edge: .bottom) {
            if let place = places.first(where: { $0.id == selected }) {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 16) {
                        Image(systemName: place.symbol).font(.largeTitle).foregroundStyle(.teal)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.title).font(.title3.weight(.semibold))
                            Text("Sample location").font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                    Divider()
                    Text("\(place.latitude, specifier: "%.4f"), \(place.longitude, specifier: "%.4f")").font(.caption.monospaced()).foregroundStyle(.secondary)
                    HStack {
                        ForEach(places) { item in
                            Button(item.title, systemImage: item.symbol) { selected = item.id }
                                .labelStyle(.iconOnly).buttonStyle(.bordered).tint(selected == item.id ? .orange : .teal)
                                .accessibilityAddTraits(selected == item.id ? .isSelected : [])
                        }
                    }
                }.padding(24).background(.regularMaterial, in: .rect(cornerRadius: 26)).padding(16)
            }
        }
        .navigationTitle("A day outside").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct Place: Identifiable {
        let id: Int; let title: String; let symbol: String; let latitude: Double; let longitude: Double
        var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
    }
}
#Preview { NavigationStack { MapPlaceSelectionDemo() } }
