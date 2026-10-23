import SwiftUI

struct SheetFullScreenDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var isFullScreen = false
    @State private var expandsAfterDismissal = false

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Button("Preview field guide") { isPresented = true }
                        .accessibilityIdentifier("present")
                    Button("Open directly in full screen") { isFullScreen = true }
                }
            }
        }
        .navigationTitle("From sheet to full screen")
        .sheet(isPresented: $isPresented, onDismiss: {
            if expandsAfterDismissal {
                expandsAfterDismissal = false
                isFullScreen = true
            }
        }) {
            NavigationStack {
                guide
                    .navigationTitle("Field guide")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Done") { isPresented = false }
                        }
                        ToolbarItem(placement: .primaryAction) {
                            Button("Open full screen", systemImage: "arrow.up.left.and.arrow.down.right") {
                                expandsAfterDismissal = true
                                isPresented = false
                            }
                        }
                    }
            }
            .presentationDetents([.medium, .large])
            .accessibilityIdentifier("capture-ready")
        }
        .fullScreenCover(isPresented: $isFullScreen) {
            NavigationStack {
                guide
                    .navigationTitle("Field guide")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { Button("Done") { isFullScreen = false } }
            }
        }
        .task { if isCapturing { isPresented = true } }
    }

    private var guide: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 84)).foregroundStyle(.teal)
                    .frame(maxWidth: .infinity).padding(.vertical, 30)
                    .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 24))
                Text("Out where the air is clear").font(.largeTitle.bold())
                Text("Leave room for a detour. Some of the best discoveries happen between the places on your list.")
                    .font(.title3).foregroundStyle(.secondary)
                Text("Take the long way")
                    .font(.headline)
                Text("Follow the ridge until the path turns toward the water. The last stretch opens into a wide meadow, with enough room to sit and watch the light change.")
            }.padding(28).frame(maxWidth: 640)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview { NavigationStack { SheetFullScreenDemo() } }
