import SwiftUI
import Charts

@available(iOS 26.0, *)
struct ThreeDimensionalChartsDemo: View {
    private struct Trail: Identifiable {
        let id: String
        let distance: Double
        let climb: Double
        let hours: Double
        let region: String
    }
    @State private var pose: Chart3DPose = .default
    private let trails = [
        Trail(id: "Cove", distance: 3.2, climb: 90, hours: 0.9, region: "Coast"),
        Trail(id: "Bluff", distance: 5.6, climb: 210, hours: 1.6, region: "Coast"),
        Trail(id: "Lagoon", distance: 7.4, climb: 120, hours: 1.9, region: "Coast"),
        Trail(id: "Pines", distance: 6.8, climb: 480, hours: 2.5, region: "Mountain"),
        Trail(id: "Ridge", distance: 9.2, climb: 760, hours: 3.8, region: "Mountain"),
        Trail(id: "Summit", distance: 12.0, climb: 980, hours: 5.2, region: "Mountain")
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Choose your next trail").font(.title2.bold())
                Text("Distance, elevation gain, and walking time").foregroundStyle(.secondary)
                Chart3D(trails) { trail in
                    PointMark(x: .value("Distance · km", trail.distance),
                              y: .value("Climb · m", trail.climb),
                              z: .value("Time · hr", trail.hours))
                        .foregroundStyle(by: .value("Region", trail.region)).symbolSize(100)
                }
                .chart3DPose($pose)
                .chartXScale(domain: 0...14).chartYScale(domain: 0...1200).chartZScale(domain: 0...6)
                .chartForegroundStyleScale(["Coast": Color.teal, "Mountain": Color.orange])
                .frame(height: 340)
                .accessibilityLabel("Six fictional trails compared by distance, climb, and time")
                HStack {
                    Button("Front") { pose = .front }
                    Button("Top") { pose = .top }
                    Button("Reset") { pose = .default }
                }.buttonStyle(.bordered)
                Divider()
                ForEach(trails) { trail in
                    HStack {
                        Circle().fill(trail.region == "Coast" ? Color.teal : .orange).frame(width: 8, height: 8)
                        Text(trail.id)
                        Spacer()
                        Text("\(trail.distance, specifier: "%.1f") km · \(Int(trail.climb)) m · \(trail.hours, specifier: "%.1f") hr")
                            .foregroundStyle(.secondary).font(.caption)
                    }
                    .accessibilityElement(children: .combine)
                }
            }.padding(24)
        }
        .navigationTitle("Trails in 3D").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { if #available(iOS 26.0, *) { NavigationStack { ThreeDimensionalChartsDemo() } } }
