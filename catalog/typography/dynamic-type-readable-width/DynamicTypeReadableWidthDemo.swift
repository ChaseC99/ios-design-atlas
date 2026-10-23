import SwiftUI

struct DynamicTypeReadableWidthDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.dynamicTypeSize) private var systemSize
    @State private var previewSize = 0
    private var size: DynamicTypeSize {
        switch previewSize { case 1: .xxxLarge; case 2: .accessibility3; default: systemSize }
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                if !capturing {
                    Picker("Text size", selection: $previewSize) {
                        Text("System").tag(0); Text("XXXL").tag(1); Text("AX 3").tag(2)
                    }.pickerStyle(.segmented).padding(.horizontal, 24)
                }
                ReadableTypeArticle().dynamicTypeSize(size)
            }.padding(.vertical, 24)
        }
        .navigationTitle("Reading room").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct ReadableTypeArticle: View {
    @ScaledMetric(relativeTo: .body) private var spacing = 20.0
    @ScaledMetric(relativeTo: .title) private var symbolSize = 42.0
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Image(systemName: "leaf").font(.system(size: symbolSize, weight: .light)).foregroundStyle(.teal)
            Text("The time it takes.").font(.system(.largeTitle, design: .serif))
            Text("Some things are better without a deadline. A conversation, a walk, the first pages of a good book.")
                .font(.custom("Georgia", size: 21, relativeTo: .body)).lineSpacing(5)
            Text("Leave a little room for the day to surprise you. Notice what changes when you stop trying to fill every minute.")
                .font(.body).foregroundStyle(.secondary).lineSpacing(4)
            Divider()
            Label("A three-minute read", systemImage: "clock").font(.footnote).foregroundStyle(.secondary)
        }.frame(maxWidth: 600, alignment: .leading).padding(.horizontal, 28).frame(maxWidth: .infinity)
    }
}
#Preview { NavigationStack { DynamicTypeReadableWidthDemo() } }
