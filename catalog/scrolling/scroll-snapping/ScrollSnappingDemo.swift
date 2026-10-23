import SwiftUI

struct ScrollSnappingDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var paging = false
    @State private var selection: Int? = 0
    var body: some View {
        VStack(spacing: 24) {
            if !capturing {
                Picker("Snapping", selection: $paging) {
                    Text("View aligned").tag(false); Text("Paging").tag(true)
                }.pickerStyle(.segmented).padding(.horizontal, 24)
            }
            Spacer(minLength: 0)
            if paging {
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0..<5) { index in card(index).padding(.horizontal, 24).containerRelativeFrame(.horizontal).id(index) }
                    }.scrollTargetLayout()
                }.scrollTargetBehavior(.paging).scrollPosition(id: $selection)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(0..<5) { index in card(index).containerRelativeFrame(.horizontal, count: 5, span: 4, spacing: 16).id(index) }
                    }.scrollTargetLayout()
                }.contentMargins(.horizontal, 24, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned).scrollPosition(id: $selection)
            }
            HStack(spacing: 8) {
                ForEach(0..<5) { index in
                    Circle().fill(selection == index ? Color.primary : Color.secondary.opacity(0.25)).frame(width: 6, height: 6)
                }
            }.accessibilityElement(children: .ignore).accessibilityLabel("Page \((selection ?? 0) + 1) of 5")
            Spacer(minLength: 0)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Collected moments").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func card(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 80) {
            Image(systemName: ["sun.max", "moon.stars", "water.waves", "leaf", "wind"][index]).font(.system(size: 64, weight: .ultraLight))
            VStack(alignment: .leading, spacing: 12) {
                Text(["Morning", "Evening", "Water", "Earth", "Air"][index]).font(.system(.largeTitle, design: .serif))
                Text("A study in small moments.").font(.subheadline)
            }
        }.frame(maxWidth: .infinity, alignment: .leading).padding(32)
            .foregroundStyle(.white).background([Color.orange, .indigo, .teal, .green, .blue][index].gradient, in: RoundedRectangle(cornerRadius: 32))
    }
}
#Preview { NavigationStack { ScrollSnappingDemo() } }
