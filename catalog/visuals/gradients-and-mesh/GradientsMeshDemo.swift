import SwiftUI

struct GradientsMeshDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var center = 0.5
    @State private var smooth = true
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [Float(center), 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [.indigo, .purple, .pink, .blue, .orange, .red, .cyan, .teal, .orange], smoothsColors: smooth)
                .frame(height: 300).clipShape(RoundedRectangle(cornerRadius: 30))
                HStack(spacing: 16) {
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 22).fill(LinearGradient(colors: [.indigo, .pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        Text("Linear").font(.caption)
                    }
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 22).fill(RadialGradient(colors: [.orange, .pink, .indigo], center: .center, startRadius: 0, endRadius: 100))
                        Text("Radial").font(.caption)
                    }
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 22).fill(AngularGradient(colors: [.orange, .pink, .indigo, .orange], center: .center))
                        Text("Angular").font(.caption)
                    }
                }.frame(height: 150)
                if !capturing {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Middle control point").font(.caption)
                        Slider(value: $center, in: 0.1...0.9)
                        Toggle("Smooth color interpolation", isOn: $smooth)
                    }
                }
            }.padding(24).frame(maxWidth: 700)
        }
        .navigationTitle("Color fields").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { GradientsMeshDemo() } }
