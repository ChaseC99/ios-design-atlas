import SwiftUI

struct WidePopoverAdaptationDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var options = false
    @State private var showDate = true
    @State private var palette = "Ocean"
    private var tint: Color { palette == "Ocean" ? .teal : palette == "Sunset" ? .orange : .indigo }
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("Postcard").font(.system(.largeTitle, design: .serif))
                Spacer()
                Button("Card options", systemImage: "slider.horizontal.3") { options = true }
                    .buttonStyle(.bordered).popover(isPresented: $options, arrowEdge: .top) {
                        NavigationStack {
                            Form {
                                Picker("Palette", selection: $palette) {
                                    Text("Ocean").tag("Ocean")
                                    Text("Sunset").tag("Sunset")
                                    Text("Night").tag("Night")
                                }
                                Toggle("Show date", isOn: $showDate)
                            }
                            .navigationTitle("Card options").navigationBarTitleDisplayMode(.inline)
                            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { options = false } } }
                        }
                        .frame(idealWidth: 340, idealHeight: 300)
                        .presentationCompactAdaptation(.sheet)
                        .presentationDetents([.medium])
                        .accessibilityIdentifier("capture-ready")
                    }
            }
            VStack(alignment: .leading, spacing: 20) {
                RoundedRectangle(cornerRadius: 22).fill(tint.gradient).aspectRatio(1.4, contentMode: .fit)
                    .overlay(Image(systemName: "sun.horizon").font(.system(size: 82, weight: .ultraLight)).foregroundStyle(.white))
                Text("Wish you were here").font(.system(.title, design: .serif))
                if showDate { Text("A quiet Sunday by the sea").foregroundStyle(.secondary) }
            }
            Spacer(minLength: 0)
        }
        .padding(24).frame(maxWidth: 700).frame(maxWidth: .infinity)
        .navigationTitle("Studio").navigationBarTitleDisplayMode(.inline)
        .task {
            if capturing {
                try? await Task.sleep(for: .milliseconds(300))
                guard !Task.isCancelled else { return }
                options = true
            }
        }
    }
}
#Preview { NavigationStack { WidePopoverAdaptationDemo() } }
