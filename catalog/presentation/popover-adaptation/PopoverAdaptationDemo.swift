import SwiftUI

struct PopoverAdaptationDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var keepPopover = false
    @State private var textSize = 18.0
    @State private var warmBackground = false

    var body: some View {
        Group {
            if isCapturing {
                trigger
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(uiColor: .systemBackground).ignoresSafeArea())
            } else {
                Form {
                    Section("Compact width") {
                        Toggle("Keep popover", isOn: $keepPopover)
                            .accessibilityIdentifier("keep-popover")
                        Text(keepPopover ? "Requests a popover in compact size classes." : "Allows the system to choose the adapted presentation.")
                            .foregroundStyle(.secondary)
                    }
                    Section { trigger }
                    Section("Compare") {
                        Text("Present with the switch off, dismiss, turn it on, and present again. Repeat on a wider device and in landscape.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Popover adaptation")
        .navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { isPresented = true } }
    }

    private var trigger: some View {
        Button("Reading options", systemImage: "textformat") { isPresented = true }
            .accessibilityIdentifier("present")
            .popover(isPresented: $isPresented) {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Reading options").font(.title2.bold())
                        Spacer()
                        Button("Done") { isPresented = false }
                    }
                    Text("Take the long way home.")
                        .font(.system(size: textSize, design: .serif))
                        .padding(20).frame(maxWidth: .infinity)
                        .background(warmBackground ? Color.orange.opacity(0.12) : Color.secondary.opacity(0.08),
                                    in: RoundedRectangle(cornerRadius: 16))
                    Slider(value: $textSize, in: 14...26, step: 1) {
                        Text("Text size")
                    } minimumValueLabel: {
                        Image(systemName: "textformat.size.smaller")
                    } maximumValueLabel: {
                        Image(systemName: "textformat.size.larger")
                    }
                    Toggle("Warm background", isOn: $warmBackground)
                }
                .padding(24)
                .frame(idealWidth: 340, maxWidth: 400)
                .presentationCompactAdaptation(keepPopover ? .popover : .automatic)
                .accessibilityIdentifier("capture-ready")
            }
    }
}

#Preview { NavigationStack { PopoverAdaptationDemo() } }
