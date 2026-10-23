import SwiftUI

struct SizeClassGeometryDemo: View {
    @Environment(\.horizontalSizeClass) private var horizontal
    @Environment(\.verticalSizeClass) private var vertical
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Room for\nsomething good.").font(.system(.largeTitle, design: .serif))
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(Int(proxy.size.width))").font(.system(size: 60, weight: .light, design: .rounded))
                        Text("× \(Int(proxy.size.height)) pt").font(.title3).foregroundStyle(.secondary)
                    }.minimumScaleFactor(0.6).lineLimit(1)
                    VStack(spacing: 18) {
                        LabeledContent("Horizontal class", value: name(horizontal))
                        LabeledContent("Vertical class", value: name(vertical))
                        LabeledContent("Available shape", value: proxy.size.width > proxy.size.height ? "Wider than tall" : "Taller than wide")
                    }.padding(24).background(.teal.opacity(0.07), in: RoundedRectangle(cornerRadius: 24))
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                        ForEach(["Look closer", "Take a breath", "Find a new path", "Keep a moment"], id: \.self) { title in
                            VStack(alignment: .leading, spacing: 30) {
                                Image(systemName: "sparkle").font(.title).foregroundStyle(.teal)
                                Text(title).font(.headline)
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(22)
                                .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 24))
                        }
                    }
                }.padding(28).frame(maxWidth: 1000).frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Available space").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func name(_ value: UserInterfaceSizeClass?) -> String {
        value == .regular ? "Regular" : value == .compact ? "Compact" : "Unspecified"
    }
}
#Preview { NavigationStack { SizeClassGeometryDemo() } }
