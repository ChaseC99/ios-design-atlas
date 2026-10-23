import SwiftUI

struct OverlayModifierOrderDemo: View {
    @State private var showsBadge = true
    @State private var padding = 20.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("A badge over the card").font(.headline)
                card
                    .overlay(alignment: .topTrailing) {
                        if showsBadge { badge.offset(x: 8, y: -8) }
                    }
                Text("A badge beside the card").font(.headline)
                HStack(alignment: .top, spacing: 16) {
                    card
                    if showsBadge { badge }
                }
                Divider()
                Text("The same padding, a different order").font(.headline)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Padding → background")
                        .padding(padding).background(.teal.opacity(0.15))
                        .overlay { Rectangle().stroke(.teal, lineWidth: 1) }
                    Text("Background → padding")
                        .background(.teal.opacity(0.15)).padding(padding)
                        .overlay { Rectangle().stroke(.teal, lineWidth: 1) }
                }
                Toggle("Show badge", isOn: $showsBadge)
                Slider(value: $padding, in: 8...28, step: 4) { Text("Padding") }
            }.padding(28).frame(maxWidth: 640).frame(maxWidth: .infinity)
        }
        .navigationTitle("Overlays and modifier order")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

    private var card: some View {
        Label("Weekend references", systemImage: "folder.fill")
            .font(.headline).foregroundStyle(.indigo)
            .padding(24).frame(maxWidth: .infinity, alignment: .leading)
            .background(.indigo.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
    }
    private var badge: some View {
        Text("NEW").font(.caption.bold()).padding(.horizontal, 10).padding(.vertical, 6)
            .foregroundStyle(.white).background(.orange, in: Capsule())
    }

}

#Preview { NavigationStack { OverlayModifierOrderDemo() } }
