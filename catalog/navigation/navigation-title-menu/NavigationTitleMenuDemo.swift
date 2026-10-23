import SwiftUI

struct NavigationTitleMenuDemo: View {
    @State private var title = "Weekend plans"
    @State private var isFavorite = true
    @State private var status = "Updated just now"
    var body: some View {
        NavigationStack {
            document
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarTitleMenu {
                    Button(isFavorite ? "Remove Favorite" : "Add to Favorites", systemImage: isFavorite ? "star.slash" : "star") {
                        isFavorite.toggle()
                        status = isFavorite ? "Added to favorites" : "Removed from favorites"
                    }
                    Button("Duplicate", systemImage: "doc.on.doc") {
                        title += " copy"
                        status = "Created a copy"
                    }
                }
        }
        .accessibilityIdentifier("capture-ready")
    }
    @ViewBuilder private var document: some View {
        if #available(iOS 26.0, *) {
            contents.navigationSubtitle(status)
        } else {
            contents
        }
    }
    private var contents: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack { Image(systemName: isFavorite ? "star.fill" : "star").foregroundStyle(.orange); Text("PERSONAL").font(.caption.weight(.semibold)).foregroundStyle(.secondary) }
                Text("A little room\nto wander.").font(.system(.largeTitle, design: .serif).weight(.medium))
                Text("Find a new café. Take the coastal path. Make time for the things that don't need a schedule.").font(.title3).foregroundStyle(.secondary)
                Divider()
                Label("Saturday · No reservations needed", systemImage: "calendar").font(.subheadline)
            }.frame(maxWidth: .infinity, alignment: .leading).padding(28)
        }
    }
}

#Preview { NavigationTitleMenuDemo() }
