import SwiftUI
import Combine
import MapKit
import CoreLocation

struct MapStylesLocationDemo: View {
    @State private var position = MapCameraPosition.region(Self.region)
    @State private var style = "Standard"
    @StateObject private var location = MapLocationStatus()
    private static let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.8024, longitude: -122.455), span: MKCoordinateSpan(latitudeDelta: 0.055, longitudeDelta: 0.055))
    var body: some View {
        Map(position: $position) {
            Marker("Sample viewpoint", systemImage: "binoculars", coordinate: Self.region.center).tint(.teal)
            if let coordinate = location.coordinate { Annotation("Your location", coordinate: coordinate) { Image(systemName: "location.circle.fill").font(.title).foregroundStyle(.blue).background(.white, in: Circle()) } }
        }
        .mapStyle(style == "Standard" ? .standard(elevation: .realistic) : style == "Muted" ? .standard(emphasis: .muted) : .hybrid(elevation: .realistic))
        .mapControls { MapCompass(); MapPitchToggle(); MapScaleView() }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 14) {
                Picker("Map style", selection: $style) {
                    Text("Standard").tag("Standard"); Text("Muted").tag("Muted"); Text("Hybrid").tag("Hybrid")
                }.pickerStyle(.segmented)
                HStack {
                    Button("Locate me", systemImage: "location") { location.request() }
                    Spacer()
                    Button("Reset view", systemImage: "arrow.counterclockwise") { withAnimation { position = .region(Self.region) } }
                }
                Text(location.message).font(.caption).foregroundStyle(.secondary)
            }.padding(20).background(.regularMaterial, in: .rect(cornerRadius: 24)).padding(16)
        }
        .onReceive(location.$coordinate) { coordinate in
            if let coordinate { withAnimation { position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))) } }
        }
        .navigationTitle("Map study").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    @MainActor private final class MapLocationStatus: NSObject, ObservableObject, CLLocationManagerDelegate {
        @Published var coordinate: CLLocationCoordinate2D?
        @Published var message = "Fixed sample region · Map imagery may need a connection."
        private lazy var manager: CLLocationManager = { let value = CLLocationManager(); value.delegate = self; return value }()
        private var requested = false
        func request() {
            guard Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") is String else { message = "Location access is not configured in this app build."; return }
            requested = true
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse: message = "Finding your location…"; manager.requestLocation()
            case .notDetermined: manager.requestWhenInUseAuthorization()
            default: message = "Location is unavailable. You can review access in Settings."
            }
        }
        nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = manager.authorizationStatus
            Task { @MainActor in
                guard requested else { return }
                if status == .authorizedAlways || status == .authorizedWhenInUse { self.manager.requestLocation() }
                else if status != .notDetermined { message = "Location permission was not granted." }
            }
        }
        nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let value = locations.last?.coordinate
            Task { @MainActor in coordinate = value; message = value == nil ? "No location fix is available." : "Current location received." }
        }
        nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            Task { @MainActor in message = "A location fix could not be obtained. Try again outdoors." }
        }
    }
}
#Preview { NavigationStack { MapStylesLocationDemo() } }
