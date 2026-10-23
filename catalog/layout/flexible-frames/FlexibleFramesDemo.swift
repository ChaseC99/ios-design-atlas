import SwiftUI

struct FlexibleFramesDemo: View {
    @State private var width = 300.0
    @State private var prioritizesTitle = true
    @State private var wrapsTitle = true
    @State private var expands = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Room for what matters").font(.title2.bold())
                HStack(spacing: 16) {
                    Image(systemName: "leaf.fill").font(.title2).foregroundStyle(.green)
                    Text("The long coastal path through the cypress grove")
                        .font(.headline)
                        .lineLimit(wrapsTitle ? nil : 1)
                        .fixedSize(horizontal: false, vertical: wrapsTitle)
                        .layoutPriority(prioritizesTitle ? 1 : 0)
                    Text("4.8 km").foregroundStyle(.secondary).fixedSize()
                }
                .padding(20).frame(width: width, alignment: .leading)
                .background(.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
                VStack(alignment: .leading, spacing: 12) {
                    Text("Intrinsic width").padding(12).background(.orange.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))
                    Text("Flexible width")
                        .padding(12).frame(maxWidth: expands ? .infinity : nil, alignment: .leading)
                        .background(.teal.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))
                }
                VStack(spacing: 20) {
                    Slider(value: $width, in: 220...340, step: 10) { Text("Available width") }
                    Toggle("Prioritize title", isOn: $prioritizesTitle)
                    Toggle("Wrap the complete title", isOn: $wrapsTitle)
                    Toggle("Expand the flexible label", isOn: $expands)
                }
            }.padding(24).frame(maxWidth: 680).frame(maxWidth: .infinity)
        }
        .navigationTitle("Frames and layout priority")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { FlexibleFramesDemo() } }
