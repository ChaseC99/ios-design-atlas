import SwiftUI

struct PopoverAnchorsDemo: View {
    @State private var isPresented = false
    @State private var edge = "Top"
    @State private var width = 280.0
    @State private var pointAnchor = false

    private var arrowEdge: Edge {
        switch edge {
        case "Bottom": .bottom
        case "Leading": .leading
        case "Trailing": .trailing
        default: .top
        }
    }

    var body: some View {
        Form {
            Section("Geometry") {
                Picker("Requested arrow edge", selection: $edge) {
                    ForEach(["Top", "Bottom", "Leading", "Trailing"], id: \.self) { Text($0) }
                }
                Toggle("Anchor to the center point", isOn: $pointAnchor)
                LabeledContent("Content width", value: "\(Int(width)) pt")
                Slider(value: $width, in: 220...340, step: 20)
                    .accessibilityLabel("Content width")
            }
            Section {
                HStack {
                    Spacer()
                    Button("Show details", systemImage: "info.circle") { isPresented = true }
                        .buttonStyle(.bordered)
                        .accessibilityIdentifier("present")
                        .popover(isPresented: $isPresented,
                                 attachmentAnchor: pointAnchor ? .point(.center) : .rect(.bounds),
                                 arrowEdge: arrowEdge) {
                            VStack(alignment: .leading, spacing: 16) {
                                Label("A little more context", systemImage: "info.circle.fill")
                                    .font(.headline)
                                Text("This presentation stays connected to the control that opened it.")
                                Button("Done") { isPresented = false }
                                    .buttonStyle(.borderedProminent)
                            }
                            .padding(24)
                            .frame(width: width)
                            .presentationCompactAdaptation(.popover)
                        }
                    Spacer()
                }
            }
            Section("Look closely") {
                Text("The anchor identifies the source. Available space and system rules can constrain the final placement. Tap outside to dismiss.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Popover anchors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationStack { PopoverAnchorsDemo() } }
