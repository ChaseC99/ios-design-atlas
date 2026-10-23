import SwiftUI
import MapKit

struct MapRouteOverlaysDemo: View {
    @State private var showArea = true
    @State private var showPath = true
    private let path = [CLLocationCoordinate2D(latitude: 37.8063, longitude: -122.4692), CLLocationCoordinate2D(latitude: 37.8046, longitude: -122.4668), CLLocationCoordinate2D(latitude: 37.8020, longitude: -122.4630), CLLocationCoordinate2D(latitude: 37.8004, longitude: -122.4590), CLLocationCoordinate2D(latitude: 37.7987, longitude: -122.4547)]
    private let area = [CLLocationCoordinate2D(latitude: 37.805, longitude: -122.466), CLLocationCoordinate2D(latitude: 37.805, longitude: -122.457), CLLocationCoordinate2D(latitude: 37.798, longitude: -122.457), CLLocationCoordinate2D(latitude: 37.798, longitude: -122.466)]
    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.8025, longitude: -122.462), span: MKCoordinateSpan(latitudeDelta: 0.019, longitudeDelta: 0.026)))) {
            if showArea { MapPolygon(coordinates: area).foregroundStyle(.teal.opacity(0.14)).stroke(.teal.opacity(0.6), lineWidth: 2) }
            if showPath { MapPolyline(coordinates: path).stroke(.orange, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round)) }
            Marker("Start", systemImage: "figure.walk", coordinate: path[0]).tint(.teal)
            Marker("Finish", systemImage: "flag.fill", coordinate: path[path.count - 1]).tint(.orange)
        }
        .mapStyle(.standard(emphasis: .muted)).mapControls { MapScaleView() }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                Text("A line through the landscape").font(.system(.title2, design: .serif))
                Text("Illustrative path · Not a calculated route").font(.subheadline).foregroundStyle(.secondary)
                HStack {
                    Toggle("Path", isOn: $showPath).toggleStyle(.button)
                    Toggle("Shaded area", isOn: $showArea).toggleStyle(.button)
                }.buttonStyle(.bordered)
            }.padding(24).background(.regularMaterial, in: .rect(cornerRadius: 26)).padding(16)
        }
        .navigationTitle("Overlay study").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { MapRouteOverlaysDemo() } }
