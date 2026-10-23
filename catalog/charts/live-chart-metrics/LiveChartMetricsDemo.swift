import SwiftUI
import Charts

struct LiveChartMetricsDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var readings = [42, 48, 51, 47, 55, 62, 58, 66, 61, 68]
    @State private var running = false
    @State private var next = 10
    private let sequence = [64, 70, 67, 74, 69, 63, 71, 76]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A steady afternoon").font(.title2.bold())
                HStack(alignment: .center, spacing: 24) {
                    Gauge(value: Double(readings.last ?? 0), in: 0...100) {
                        Text("Focus")
                    } currentValueLabel: { Text("\(readings.last ?? 0)").monospacedDigit() }
                    .gaugeStyle(.accessoryCircular).tint(.teal).scaleEffect(1.15).padding(10)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(readings.last ?? 0)%").font(.largeTitle.bold()).monospacedDigit()
                        Text(running ? "Updating sample readings" : "Sample readings paused").foregroundStyle(.secondary).font(.subheadline)
                    }
                }
                Chart(readings.indices, id: \.self) { index in
                    AreaMark(x: .value("Reading", index), y: .value("Focus", readings[index]))
                        .foregroundStyle(.teal.opacity(0.15))
                    LineMark(x: .value("Reading", index), y: .value("Focus", readings[index]))
                        .foregroundStyle(.teal).interpolationMethod(.monotone)
                }
                .chartYScale(domain: 0...100)
                .chartXAxis(.hidden).chartYAxisLabel("Focus %")
                .frame(height: 240)
                .accessibilityLabel("Fictional focus readings")
                HStack {
                    Button(running ? "Pause" : "Play", systemImage: running ? "pause.fill" : "play.fill") { running.toggle() }.buttonStyle(.borderedProminent)
                    Button("Add reading", systemImage: "plus") { append() }.buttonStyle(.bordered).disabled(running)
                }
                LabeledContent("Average", value: "\(readings.reduce(0, +) / readings.count)%")
                Text("Synthetic readings illustrate updates; they do not measure health or attention.").font(.footnote).foregroundStyle(.secondary)
            }.padding(24)
        }
        .task(id: running) {
            guard running else { return }
            while !Task.isCancelled {
                do { try await Task.sleep(for: .seconds(1.5)) } catch { return }
                guard !Task.isCancelled else { return }; append()
            }
        }
        .navigationTitle("Live metrics").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func append() {
        withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.4)) {
            readings.append(sequence[next % sequence.count]); next += 1
            if readings.count > 20 { readings.removeFirst() }
        }
    }
}

#Preview { NavigationStack { LiveChartMetricsDemo() } }
