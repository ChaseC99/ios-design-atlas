import SwiftUI

struct SlidersAndSteppersDemo: View {
    @State private var brightness = 0.6
    @State private var distance = 5.0
    @State private var people = 2
    @State private var feedback = true
    var body: some View {
        Form {
            Section("Continuous") {
                HStack {
                    Label("Reading light", systemImage: "sun.max")
                    Spacer()
                    Text(brightness, format: .percent.precision(.fractionLength(0))).monospacedDigit()
                }
                Slider(value: $brightness, in: 0...1) { Text("Reading light") }
                    minimumValueLabel: { Image(systemName: "sun.min") }
                    maximumValueLabel: { Image(systemName: "sun.max.fill") }
            }
            Section("Stepped") {
                LabeledContent("Walk distance", value: "\(Int(distance)) km")
                Slider(value: $distance, in: 1...12, step: 1) { Text("Walk distance") }
                    minimumValueLabel: { Text("1 km") }
                    maximumValueLabel: { Text("12 km") }
                Toggle("Selection feedback", isOn: $feedback)
            }
            Section("Precise adjustments") {
                Stepper(value: $people, in: 1...12) {
                    LabeledContent("People", value: String(people))
                }
                Button("Reset values") { brightness = 0.6; distance = 5; people = 2 }
            }
        }
        .sensoryFeedback(.selection, trigger: Int(distance)) { _, _ in feedback }
        .navigationTitle("Sliders and steppers")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { SlidersAndSteppersDemo() } }
