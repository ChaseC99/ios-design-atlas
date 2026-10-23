import SwiftUI

struct MenuPrimaryActionsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var saved = false
    @State private var destination = "Personal"
    @State private var copies = 0

    var body: some View {
        VStack(spacing: 28) {
            if !isCapturing {
                Image(systemName: "sun.horizon.fill").font(.system(size: 72)).foregroundStyle(.orange)
                Text("Morning light").font(.title.bold())
            }
            Menu {
                Button("Save a copy", systemImage: "doc.on.doc") { copies += 1; saved = true }
                    .accessibilityIdentifier("capture-ready")
                Menu("Save to") {
                    ForEach(["Personal", "Travel", "Shared"], id: \.self) { folder in
                        Button(folder) { destination = folder; saved = true }
                    }
                }
                Button("Remove saved item", role: .destructive) { saved = false }
            } label: {
                Label(saved ? "Saved" : "Save reference", systemImage: saved ? "bookmark.fill" : "bookmark")
            } primaryAction: {
                saved.toggle()
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            .accessibilityIdentifier("capture-open")
            if !isCapturing {
                Text(saved ? "Saved to \(destination)" : "Not saved yet").foregroundStyle(.secondary)
                if copies > 0 { Text("\(copies) copies created").font(.caption).foregroundStyle(.secondary) }
            }
        }
        .padding(28).frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Menus with a primary action")
    }
}

#Preview { NavigationStack { MenuPrimaryActionsDemo() } }
