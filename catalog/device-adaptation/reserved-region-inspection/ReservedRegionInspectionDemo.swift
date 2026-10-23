import SwiftUI

@available(iOS 27.1, *)
struct ReservedRegionInspectionDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var includeInactive = true
    var body: some View {
        GeometryReader { proxy in
            let options: ReservedRegion.QueryOptions = includeInactive ? [.includeInactive] : []
            let divisions = proxy.reservedRegions(kind: .division, options: options)
            let occlusions = proxy.reservedRegions(kind: .occlusion, options: options)
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        Image(systemName: "rectangle.split.2x1").font(.system(size: 52, weight: .light)).foregroundStyle(.teal)
                        Text("Space the system reserves.").font(.system(.largeTitle, design: .serif))
                        LabeledContent("Available width", value: "\(Int(proxy.size.width)) pt")
                        LabeledContent("Available height", value: "\(Int(proxy.size.height)) pt")
                        Divider()
                        LabeledContent("Division regions", value: "\(divisions.count)")
                        LabeledContent("Occlusion regions", value: "\(occlusions.count)")
                        if divisions.isEmpty && occlusions.isEmpty {
                            Text("No intersecting reserved regions are reported in this view.").foregroundStyle(.secondary)
                        }
                        ForEach(divisions + occlusions) { region in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(region.kind == .division ? "Division" : "Occlusion").font(.headline)
                                Text("\(Int(region.frame.width)) × \(Int(region.frame.height)) pt · \(region.isActive ? "Active" : "Inactive")")
                                    .font(.caption.monospaced()).foregroundStyle(.secondary)
                            }
                        }
                        if !capturing { Toggle("Include inactive regions", isOn: $includeInactive) }
                    }.padding(28).frame(maxWidth: 620).frame(maxWidth: .infinity)
                }
                ForEach(divisions + occlusions) { region in
                    Rectangle().strokeBorder(region.kind == .division ? Color.teal : .orange, style: StrokeStyle(lineWidth: 2, dash: region.isActive ? [] : [6, 4]))
                        .frame(width: max(2, region.frame.width), height: max(2, region.frame.height))
                        .position(x: region.frame.midX, y: region.frame.midY)
                        .allowsHitTesting(false).accessibilityHidden(true)
                }
            }.clipped()
        }
        .navigationTitle("Reserved regions").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.1, *) { NavigationStack { ReservedRegionInspectionDemo() } } }
