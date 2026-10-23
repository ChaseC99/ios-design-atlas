import SwiftUI

struct AdaptiveCompositionDemo: View {
    @State private var width = 320.0
    @State private var accessibilityText = false
    @State private var saved = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Image(systemName: "mountain.2.fill").font(.system(size: 64)).foregroundStyle(.teal)
                Text("Room to breathe").font(.largeTitle.bold())
                Text("A readable layout stays comfortable as the available space changes.")
                    .font(.title3).foregroundStyle(.secondary)
                AdaptiveWalkActions(saved: $saved)
                    .dynamicTypeSize(accessibilityText ? .accessibility2 : .large)
                    .padding(20).frame(width: width, alignment: .leading)
                    .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
                Slider(value: $width, in: 240...340, step: 20) { Text("Available width") }
                Toggle("Accessibility text size", isOn: $accessibilityText)
            }.padding(24).frame(maxWidth: 600).frame(maxWidth: .infinity)
        }
        .navigationTitle("Adaptive composition")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct AdaptiveWalkActions: View {
    @Environment(\.dynamicTypeSize) private var textSize
    @Binding var saved: Bool
    var body: some View {
        if textSize.isAccessibilitySize {
            vertical
        } else {
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 16) { title; action }.fixedSize()
                vertical
            }
        }
    }
    private var title: some View { Text("The coastal path").font(.headline) }
    private var action: some View {
        Button(saved ? "Saved" : "Save for later") { saved.toggle() }.buttonStyle(.bordered)
    }
    private var vertical: some View {
        VStack(alignment: .leading, spacing: 16) { title; action }
    }
}

#Preview { NavigationStack { AdaptiveCompositionDemo() } }
