import SwiftUI

struct TapAndPressDemo: View {
    @GestureState private var pressing = false
    @State private var isFavorite = false
    @State private var showsDetails = false
    @State private var isSelected = false
    @State private var result = "Ready"
    var body: some View {
        Form {
            Section {
                VStack(spacing: 18) {
                    Image(systemName: "mountain.2.fill").font(.system(size: 54)).foregroundStyle(.teal)
                    Text("High country").font(.title2.bold())
                    Text("A quiet trail above the tree line.").foregroundStyle(.secondary)
                    HStack {
                        if isFavorite { Label("Favorite", systemImage: "heart.fill").foregroundStyle(.pink) }
                        if isSelected { Label("Selected", systemImage: "checkmark.circle.fill").foregroundStyle(.teal) }
                    }.font(.subheadline)
                    if showsDetails { Text("6.4 km · 420 m elevation gain").font(.subheadline.monospacedDigit()) }
                }
                .frame(maxWidth: .infinity, minHeight: 235)
                .padding()
                .background(pressing ? Color.teal.opacity(0.16) : Color.teal.opacity(0.06), in: .rect(cornerRadius: 22))
                .contentShape(.rect)
                .gesture(LongPressGesture(minimumDuration: 0.6, maximumDistance: 20)
                    .updating($pressing) { value, state, _ in state = value }
                    .exclusively(before: TapGesture(count: 2).exclusively(before: TapGesture()))
                    .onEnded { value in
                        switch value {
                        case .first: select()
                        case .second(.first): favorite()
                        case .second(.second): details()
                        }
                    })
                .accessibilityElement(children: .combine)
                .accessibilityLabel("High country")
                .accessibilityValue("\(isFavorite ? "Favorite. " : "")\(isSelected ? "Selected. " : "")\(showsDetails ? "6.4 kilometers, 420 meters elevation gain." : "")")
                .accessibilityAction(named: "Show details") { details() }
                .accessibilityAction(named: "Toggle favorite") { favorite() }
                .accessibilityAction(named: "Toggle selection") { select() }
                LabeledContent("Interaction", value: pressing ? "Holding…" : result)
            }
            Section("Equivalent actions") {
                Button(showsDetails ? "Hide details · single tap" : "Show details · single tap", action: details)
                Button(isFavorite ? "Remove favorite · double tap" : "Favorite · double tap", action: favorite)
                Button(isSelected ? "Deselect · long press" : "Select · long press", action: select)
            }
        }
        .navigationTitle("Taps and long presses")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func details() { showsDetails.toggle(); result = "Single tap" }
    private func favorite() { isFavorite.toggle(); result = "Double tap" }
    private func select() { isSelected.toggle(); result = "Long press" }
}

#Preview { NavigationStack { TapAndPressDemo() } }
