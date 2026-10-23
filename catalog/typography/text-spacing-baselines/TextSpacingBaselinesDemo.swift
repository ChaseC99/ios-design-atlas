import SwiftUI

struct TextSpacingBaselinesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var letterSpacing = 2.0
    @State private var leading = 8.0
    @State private var baseline = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 36) {
                Text("STILL / IN MOTION").font(.caption.weight(.semibold)).tracking(letterSpacing).foregroundStyle(.secondary)
                Text("A slower\nkind of day.").font(.system(.largeTitle, design: .serif)).kerning(-0.5)
                HStack(alignment: baseline ? .firstTextBaseline : .center, spacing: 8) {
                    Text("24").font(.system(size: 72, weight: .light, design: .rounded))
                    Text("moments").font(.title3).foregroundStyle(.secondary)
                }
                Text("The space between things matters. Between words, between plans, between one thought and the next. Give the page a little room and let the reader set the pace.")
                    .font(.body).lineSpacing(leading)
                if !capturing {
                    VStack(alignment: .leading) {
                        Text("Tracking \(letterSpacing, specifier: "%.1f")").font(.caption)
                        Slider(value: $letterSpacing, in: 0...5)
                        Text("Line spacing \(Int(leading))").font(.caption)
                        Slider(value: $leading, in: 0...16)
                        Toggle("Align on the first baseline", isOn: $baseline)
                    }
                }
            }.padding(28).frame(maxWidth: 640)
        }
        .navigationTitle("Space and rhythm").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { TextSpacingBaselinesDemo() } }
