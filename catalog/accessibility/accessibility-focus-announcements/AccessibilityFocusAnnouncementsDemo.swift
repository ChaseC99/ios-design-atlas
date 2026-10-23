import SwiftUI
import Accessibility

struct AccessibilityFocusAnnouncementsDemo: View {
    private enum Focus: Hashable { case launch, heading }
    @State private var presented = false
    @State private var saved = false
    @AccessibilityFocusState private var focus: Focus?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Group {
            if isCapturing { Color(uiColor: .systemBackground).ignoresSafeArea() }
            else {
                Form {
                    Button("Review collection", systemImage: "folder") { presented = true }
                        .accessibilityFocused($focus, equals: .launch)
                    if saved { Label("Collection saved", systemImage: "checkmark.circle").foregroundStyle(.green) }
                }
            }
        }
        .navigationTitle("Focus and feedback").navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $presented, onDismiss: { focus = .launch }) {
            NavigationStack {
                VStack(alignment: .leading, spacing: 24) {
                    Label("Ready to keep", systemImage: "bookmark.fill").font(.title.bold())
                        .accessibilityAddTraits(.isHeader).accessibilityFocused($focus, equals: .heading)
                    Text("A slower weekend").font(.title2)
                    Text("Six places, a coastal path, and a little room for the unexpected.").foregroundStyle(.secondary)
                    Button("Save collection") {
                        saved = true; presented = false
                        AccessibilityNotification.Announcement("Collection saved").post()
                    }.buttonStyle(.borderedProminent)
                }.frame(maxWidth: .infinity, alignment: .leading).padding(28)
                    .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { presented = false } } }
                    .task { try? await Task.sleep(for: .milliseconds(400)); focus = .heading }
                    .accessibilityIdentifier("capture-ready")
            }.presentationDetents([.medium])
        }
        .task { if isCapturing { presented = true } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { AccessibilityFocusAnnouncementsDemo() } }
