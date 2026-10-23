import SwiftUI

struct DynamicTypeLayoutsDemo: View {
    @Environment(\.dynamicTypeSize) private var systemSize
    @Environment(\.legibilityWeight) private var systemLegibility
    @State private var size: DynamicTypeSize?
    @State private var bold = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if !isCapturing {
                    Picker("Text size", selection: $size) {
                        Text("System setting").tag(Optional<DynamicTypeSize>.none)
                        ForEach(DynamicTypeSize.allCases, id: \.self) { Text(String(describing: $0)).tag(Optional($0)) }
                    }
                    Toggle("Preview Bold Text", isOn: $bold)
                }
                DynamicTypeReadingCard()
                    .dynamicTypeSize(size ?? systemSize)
                    .environment(\.legibilityWeight, bold ? .bold : systemLegibility)
            }.padding(24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Made to grow").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct DynamicTypeReadingCard: View {
    @State private var reading = false
    @State private var saved = false
    @Environment(\.dynamicTypeSize) private var size
    @ScaledMetric(relativeTo: .title) private var symbolSize = 56
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "book.pages").font(.system(size: symbolSize)).foregroundStyle(.indigo).accessibilityHidden(true)
            Text("A little room\nto slow down.").font(.system(.largeTitle, design: .serif).weight(.semibold)).accessibilityAddTraits(.isHeader)
            Text("Keep the things that matter close. A familiar path, a good book, and enough time to notice the afternoon.").font(.body)
            if reading { Text("The first chapter begins with a familiar path and a different way of looking at it.").font(.body) }
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 12) { actions }
                VStack(alignment: .leading, spacing: 12) { actions }
            }
        }
        .padding(24).background(.background, in: .rect(cornerRadius: 28))
    }
    @ViewBuilder private var actions: some View {
        Button(reading ? "Close chapter" : "Start reading", systemImage: "book") { reading.toggle() }.buttonStyle(.borderedProminent)
        Button(saved ? "Saved" : "Save for later", systemImage: saved ? "bookmark.fill" : "bookmark") { saved.toggle() }.buttonStyle(.bordered)
    }
}

#Preview { NavigationStack { DynamicTypeLayoutsDemo() } }
