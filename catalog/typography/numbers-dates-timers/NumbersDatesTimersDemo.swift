import SwiftUI

struct NumbersDatesTimersDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var distance = 4.8
    @State private var start = Date()
    @State private var running = false
    private let reference = Date(timeIntervalSince1970: 1_788_177_600)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("THE LONG WAY HOME").font(.caption2).tracking(2).foregroundStyle(.secondary)
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(distance, format: .number.precision(.fractionLength(1)))
                        .font(.system(size: 76, weight: .light, design: .rounded)).monospacedDigit()
                        .contentTransition(.numericText())
                    Text("km").font(.title2).foregroundStyle(.secondary)
                }
                Divider()
                VStack(alignment: .leading, spacing: 12) {
                    Text(reference, format: .dateTime.month(.wide).day().year()).font(.title3)
                    Text(reference, format: .dateTime.weekday(.wide)).foregroundStyle(.secondary)
                    Text(Duration.seconds(3_661), format: .time(pattern: .hourMinuteSecond)).monospacedDigit().font(.title2)
                }
                if !capturing {
                    Stepper("Distance", value: $distance, in: 0...99.9, step: 0.1).animation(.default, value: distance)
                    Toggle("Run timer", isOn: $running).onChange(of: running) { _, active in if active { start = Date() } }
                    if running {
                        Text(start, style: .timer).font(.largeTitle).monospacedDigit()
                        Text(start, style: .relative).font(.caption).foregroundStyle(.secondary)
                    }
                }
            }.padding(28).frame(maxWidth: 620)
        }
        .navigationTitle("A few useful numbers").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { NumbersDatesTimersDemo() } }
