import SwiftUI

struct ToolbarPlacementsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var index = 0
    @State private var favorites: Set<Int> = []
    @State private var labeled = false
    private let titles = ["Blue hour", "Golden morning", "Still water"]
    private let colors: [Color] = [.indigo, .orange, .teal]
    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 20)
            RoundedRectangle(cornerRadius: 32).fill(colors[index].gradient)
                .overlay(Image(systemName: ["moon.stars", "sun.max", "water.waves"][index])
                    .font(.system(size: 84, weight: .ultraLight)).foregroundStyle(.white))
                .aspectRatio(0.9, contentMode: .fit)
            VStack(spacing: 8) {
                Text(titles[index]).font(.system(.title, design: .serif))
                Text("STUDY \(index + 1) / 3").font(.caption).tracking(2).foregroundStyle(.secondary)
            }
            if !capturing { Toggle("Show text labels", isOn: $labeled) }
            Spacer(minLength: 20)
        }.padding(28)
        .navigationTitle("Light studies").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { index = 0 } label: { actionLabel("First", symbol: "backward.end") }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if favorites.contains(index) { favorites.remove(index) } else { favorites.insert(index) }
                } label: { actionLabel(favorites.contains(index) ? "Unsave" : "Save", symbol: favorites.contains(index) ? "bookmark.fill" : "bookmark") }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button { index = max(index - 1, 0) } label: { actionLabel("Previous", symbol: "chevron.left") }.disabled(index == 0)
                Spacer()
                Text("\(index + 1) of 3").font(.subheadline).foregroundStyle(.secondary)
                Spacer()
                Button { index = min(index + 1, 2) } label: { actionLabel("Next", symbol: "chevron.right") }.disabled(index == 2)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
    @ViewBuilder private func actionLabel(_ title: String, symbol: String) -> some View {
        if labeled { Label(title, systemImage: symbol).labelStyle(.titleAndIcon) }
        else { Label(title, systemImage: symbol).labelStyle(.iconOnly) }
    }
}
#Preview { NavigationStack { ToolbarPlacementsDemo() } }
