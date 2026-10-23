import SwiftUI

struct MasksBlendingOverlaysDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var mode = 0
    @State private var overlap = 28.0
    private var blend: BlendMode { mode == 1 ? .multiply : mode == 2 ? .screen : .normal }
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                LinearGradient(colors: [.indigo, .teal, .orange], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 140)
                    .mask(Text("LIGHT").font(.system(size: 80, weight: .black, design: .rounded)).minimumScaleFactor(0.4))
                    .accessibilityLabel("Light")
                ZStack {
                    RoundedRectangle(cornerRadius: 28).fill(Color(uiColor: .secondarySystemBackground))
                    Circle().fill(.pink).frame(width: 150).offset(x: -overlap)
                    Circle().fill(.cyan).frame(width: 150).offset(x: overlap).blendMode(blend)
                }.frame(height: 240).compositingGroup()
                    .overlay(alignment: .bottom) {
                        Text(["Normal", "Multiply", "Screen"][mode]).font(.caption.weight(.medium))
                            .padding(12).background(.regularMaterial, in: Capsule()).padding(16)
                    }
                if !capturing {
                    Picker("Blend", selection: $mode) {
                        Text("Normal").tag(0); Text("Multiply").tag(1); Text("Screen").tag(2)
                    }.pickerStyle(.segmented)
                    Slider(value: $overlap, in: 0...70) { Text("Circle separation") }
                }
            }.padding(28).frame(maxWidth: 640)
        }
        .navigationTitle("Color in layers").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { MasksBlendingOverlaysDemo() } }
