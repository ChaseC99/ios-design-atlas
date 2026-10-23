import SwiftUI

struct PopoverAdaptationDemo: View {
    @State private var isPresented = false
    @State private var keepPopover = false

    var body: some View {
        Form {
            Section("Compact width") {
                Toggle("Keep popover", isOn: $keepPopover)
                    .accessibilityIdentifier("keep-popover")
                Text(keepPopover ? "Requests a popover in compact size classes." : "Allows the system to choose the adapted presentation.")
                    .foregroundStyle(.secondary)
            }
            Section {
                Button("Show reading options", systemImage: "textformat") { isPresented = true }
                    .accessibilityIdentifier("present")
                    .popover(isPresented: $isPresented) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Reading options").font(.title2.bold())
                            Text("The same content can appear in an anchored popover or an adapted sheet.")
                            Button("Done") { isPresented = false }
                                .buttonStyle(.borderedProminent)
                        }
                        .padding(24)
                        .frame(idealWidth: 320, maxWidth: 400)
                        .presentationCompactAdaptation(keepPopover ? .popover : .automatic)
                    }
            }
            Section("Compare") {
                Text("Present with the switch off, dismiss, turn it on, and present again. Repeat on a wider device and in landscape.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Popover adaptation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationStack { PopoverAdaptationDemo() } }
