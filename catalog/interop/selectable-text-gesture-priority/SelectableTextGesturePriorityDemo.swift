import SwiftUI

struct SelectableTextGesturePriorityDemo: View {
    @State private var policy = "System only"
    @State private var taps = 0
    private var passage: some View {
        Text("Take the long way home. Notice the light on the water, the sound of the trees, and the things you usually walk past.")
            .font(.system(.title2, design: .serif)).lineSpacing(7)
            .textSelection(.enabled)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(26).background(.background, in: .rect(cornerRadius: 24))
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Words worth keeping.").font(.largeTitle.bold())
                Picker("Gesture policy", selection: $policy) {
                    Text("System only").tag("System only")
                    Text("Simultaneous").tag("Simultaneous")
                    Text("High priority").tag("High priority")
                }.pickerStyle(.menu)
                Group {
                    if policy == "High priority" { passage.highPriorityGesture(TapGesture(count: 2).onEnded { taps += 1 }) }
                    else if policy == "Simultaneous" { passage.simultaneousGesture(TapGesture(count: 2).onEnded { taps += 1 }) }
                    else { passage }
                }
                LabeledContent("Custom double-taps", value: "\(taps)").monospacedDigit()
                Button("Reset count") { taps = 0 }.buttonStyle(.bordered)
                Text("Long-press or double-tap the passage to inspect the system’s selection interaction.").font(.subheadline).foregroundStyle(.secondary)
            }.padding(24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Text and gestures").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SelectableTextGesturePriorityDemo() } }
