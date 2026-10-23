import SwiftUI
import MapKit

struct NativeAnnotationClusteringDemo: View {
    @State private var reset = 0
    @State private var selected = "36 sample points"
    var body: some View {
        ClusterMap(reset: reset, selected: $selected)
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 16) {
                    Image(systemName: "mappin.and.ellipse").font(.title2).foregroundStyle(.teal)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(selected).font(.headline)
                        Text("Zoom to separate nearby markers").font(.caption).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Reset map", systemImage: "arrow.counterclockwise") { reset += 1 }.labelStyle(.iconOnly).buttonStyle(.bordered)
                }.padding(20).background(.regularMaterial, in: .rect(cornerRadius: 24)).padding(16)
            }
            .navigationTitle("Places together").navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier("capture-ready")
    }
    private struct ClusterMap: UIViewRepresentable {
        let reset: Int
        @Binding var selected: String
        private let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.802, longitude: -122.459), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.06))
        func makeCoordinator() -> Coordinator { Coordinator(self) }
        func makeUIView(context: Context) -> MKMapView {
            let map = MKMapView()
            map.delegate = context.coordinator
            map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "sample")
            map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
            map.setRegion(region, animated: false)
            for index in 0..<36 {
                let group = index / 12
                let annotation = MKPointAnnotation()
                annotation.title = "Sample point \(index + 1)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: 37.797 + Double(group) * 0.005 + Double(index % 4) * 0.0006, longitude: -122.47 + Double(group) * 0.01 + Double(index % 3) * 0.0007)
                map.addAnnotation(annotation)
            }
            return map
        }
        func updateUIView(_ map: MKMapView, context: Context) {
            context.coordinator.parent = self
            if context.coordinator.lastReset != reset {
                context.coordinator.lastReset = reset
                map.setRegion(region, animated: true)
            }
        }
        final class Coordinator: NSObject, MKMapViewDelegate {
            var parent: ClusterMap
            var lastReset = 0
            init(_ parent: ClusterMap) { self.parent = parent }
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                if annotation is MKUserLocation { return nil }
                if annotation is MKClusterAnnotation { return nil }
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: "sample", for: annotation) as! MKMarkerAnnotationView
                view.clusteringIdentifier = "sample-place"
                view.markerTintColor = .systemTeal
                view.glyphImage = UIImage(systemName: "leaf.fill")
                view.canShowCallout = true
                return view
            }
            func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
                if let cluster = annotation as? MKClusterAnnotation { parent.selected = "\(cluster.memberAnnotations.count) sample points" }
                else { parent.selected = (annotation.title ?? nil) ?? "Sample point" }
            }
        }
    }
}
#Preview { NavigationStack { NativeAnnotationClusteringDemo() } }
