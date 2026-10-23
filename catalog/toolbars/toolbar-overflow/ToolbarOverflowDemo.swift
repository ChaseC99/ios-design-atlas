import SwiftUI

@available(iOS 27.0, *)
struct ToolbarOverflowDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var longLabels = false
    @State private var saved = false
    @State private var starred = false
    @State private var duplicated = 0
    @State private var archived = false
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            RoundedRectangle(cornerRadius: 28).fill(.indigo.gradient).frame(height: 280)
                .overlay(Image(systemName: "moon.stars").font(.system(size: 80, weight: .ultraLight)).foregroundStyle(.white))
            Text(archived ? "Archived study" : "After hours").font(.system(.largeTitle, design: .serif))
            Text(saved ? "Saved to your collection" : "A study in quiet colors.").font(.title3).foregroundStyle(.secondary)
            if starred { Label("Favorite", systemImage: "star.fill").foregroundStyle(.orange) }
            if duplicated > 0 { Text("Copies created: \(duplicated)").font(.subheadline) }
            if !capturing { Toggle("Long action labels", isOn: $longLabels) }
            Spacer()
        }.padding(28)
        .navigationTitle("Study").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(saved ? "Saved" : longLabels ? "Save to collection" : "Save", systemImage: "bookmark") { saved.toggle() }
            }.visibilityPriority(.high)
            ToolbarItem(placement: .topBarTrailing) {
                Button(longLabels ? "Add to favorites" : "Favorite", systemImage: "star") { starred.toggle() }
            }.visibilityPriority(.automatic)
            ToolbarItem(placement: .topBarTrailing) {
                Button(longLabels ? "Create another copy" : "Duplicate", systemImage: "plus.square.on.square") { duplicated += 1 }
            }.visibilityPriority(.low)
            ToolbarItem(placement: .topBarTrailing) {
                Button(archived ? "Unarchive" : "Archive", systemImage: "archivebox") { archived.toggle() }
            }.visibilityPriority(.low)
            ToolbarItem(placement: .topBarTrailing) {
                Button("Reset", systemImage: "arrow.counterclockwise") { saved = false; starred = false; duplicated = 0; archived = false }
            }.visibilityPriority(.low)
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.0, *) { NavigationStack { ToolbarOverflowDemo() } } }
