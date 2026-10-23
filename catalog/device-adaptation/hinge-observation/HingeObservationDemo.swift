import SwiftUI

@available(iOS 27.1, *)
struct HingeObservationDemo: View {
    @State private var hinge: DeviceHinge?
    @State private var receivedUpdate = false
    var body: some View {
        Group {
            if let hinge {
                VStack(spacing: 28) {
                    Image(systemName: "rectangle.split.2x1").font(.system(size: 64, weight: .light)).foregroundStyle(.teal)
                    Text(hinge.angle.degrees, format: .number.precision(.fractionLength(0)))
                        .font(.system(size: 88, weight: .light, design: .rounded)).monospacedDigit()
                        .accessibilityLabel("Hinge angle, \(Int(hinge.angle.degrees)) degrees")
                    Text(status(hinge)).font(.title2)
                    Text("Reported by this device").font(.caption).foregroundStyle(.secondary)
                }.padding(28).frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ContentUnavailableView(receivedUpdate ? "No hinge reported" : "Waiting for a hinge update",
                                       systemImage: "rectangle.split.2x1",
                                       description: Text("Use a supported folding device and change its pose to inspect the live hinge state."))
            }
        }
        .onHingeChange { _, context in hinge = context.hinge; receivedUpdate = true }
        .navigationTitle("Hinge state").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func status(_ hinge: DeviceHinge) -> String {
        switch hinge.status {
        case .closed: "Closed"
        case .partiallyOpen: "Partially open"
        case .fullyOpen: "Fully open"
        default: "System-defined state"
        }
    }
}
#Preview { if #available(iOS 27.1, *) { NavigationStack { HingeObservationDemo() } } }
