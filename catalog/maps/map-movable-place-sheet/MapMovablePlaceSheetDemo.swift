import SwiftUI
import MapKit

struct MapMovablePlaceSheetDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var presented = false
    @State private var detent: PresentationDetent = .height(250)
    @State private var saved = false
    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.805, longitude: -122.458), span: MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.045)))) {
            Marker("Morning viewpoint", systemImage: "sun.horizon", coordinate: CLLocationCoordinate2D(latitude: 37.8064, longitude: -122.4702)).tint(.teal)
        }
        .mapControls { MapCompass(); MapScaleView() }
        .safeAreaInset(edge: .bottom) {
            if !presented { Button("View sample place", systemImage: "mappin.circle.fill") { presented = true }.buttonStyle(.borderedProminent).padding(24) }
        }
        .sheet(isPresented: $presented) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Morning viewpoint").font(.system(.title2, design: .serif))
                            Text("Sample place · Views").foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Close", systemImage: "xmark") { presented = false }.labelStyle(.iconOnly).buttonStyle(.bordered)
                    }
                    Button(saved ? "Saved" : "Save place", systemImage: saved ? "checkmark" : "bookmark") { saved.toggle() }
                        .buttonStyle(.borderedProminent)
                    Divider()
                    Text("A place to pause").font(.headline)
                    Text("A sample card for exploring a map and reading details without leaving the surrounding area.").foregroundStyle(.secondary)
                    LabeledContent("Latitude", value: "37.8064")
                    LabeledContent("Longitude", value: "−122.4702")
                }.padding(24)
            }
            .presentationDetents([.height(250), .medium, .large], selection: $detent)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("capture-ready")
        }
        .navigationTitle("Explore").navigationBarTitleDisplayMode(.inline)
        .task { if capturing { try? await Task.sleep(for: .milliseconds(300)); if !Task.isCancelled { presented = true } } }
    }
}
#Preview { NavigationStack { MapMovablePlaceSheetDemo() } }
