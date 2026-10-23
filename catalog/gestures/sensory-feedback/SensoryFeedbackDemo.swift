import SwiftUI
import UIKit

struct SensoryFeedbackDemo: View {
    private enum Cue: String, CaseIterable {
        case selection = "Selection", impact = "Impact", success = "Success", warning = "Warning", error = "Error"
        var symbol: String {
            switch self { case .selection: "checkmark.circle"; case .impact: "circle.inset.filled"; case .success: "checkmark.seal.fill"; case .warning: "exclamationmark.triangle.fill"; case .error: "xmark.octagon.fill" }
        }
        var color: Color {
            switch self { case .selection, .impact: .teal; case .success: .green; case .warning: .orange; case .error: .red }
        }
        var feedback: SensoryFeedback {
            switch self { case .selection: .selection; case .impact: .impact(weight: .medium, intensity: 0.7); case .success: .success; case .warning: .warning; case .error: .error }
        }
        var message: String {
            switch self { case .selection: "Trail selected"; case .impact: "Item snapped into place"; case .success: "Collection saved"; case .warning: "Storage almost full"; case .error: "Couldn’t save this sample" }
        }
    }
    @State private var cue = Cue.success
    @State private var lastCue = Cue.success
    @State private var trigger = 0
    @State private var haptics = true
    @State private var announce = true
    var body: some View {
        Form {
            Section {
                VStack(spacing: 18) {
                    Image(systemName: trigger == 0 ? "hand.tap.fill" : lastCue.symbol)
                        .font(.system(size: 64)).foregroundStyle(trigger == 0 ? .teal : lastCue.color)
                    Text(trigger == 0 ? "A touch of feedback" : lastCue.message).font(.title2.bold()).multilineTextAlignment(.center)
                    Text(trigger == 0 ? "Ready" : "\(lastCue.rawValue) · \(trigger) \(trigger == 1 ? "interaction" : "interactions")")
                        .foregroundStyle(.secondary).font(.subheadline)
                }.frame(maxWidth: .infinity, minHeight: 240).padding(.vertical)
                Button("Play \(cue.rawValue.lowercased()) cue") {
                    lastCue = cue
                    trigger += 1
                    if announce { UIAccessibility.post(notification: .announcement, argument: cue.message) }
                }.buttonStyle(.borderedProminent)
            }
            Section("Feedback") {
                Picker("Cue", selection: $cue) { ForEach(Cue.allCases, id: \.self) { Text($0.rawValue).tag($0) } }
                Toggle("Haptics", isOn: $haptics)
                Toggle("VoiceOver announcement", isOn: $announce)
            }
        }
        .sensoryFeedback(trigger: trigger) { _, _ in haptics ? lastCue.feedback : nil }
        .navigationTitle("Sensory feedback").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SensoryFeedbackDemo() } }
