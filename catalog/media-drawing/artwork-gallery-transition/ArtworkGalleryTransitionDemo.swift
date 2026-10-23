import SwiftUI

struct ArtworkGalleryTransitionDemo: View {
    @Namespace private var gallery
    @State private var selected: Artwork?
    private let works = [Artwork(id: 0, title: "Blue hour", color: .indigo), Artwork(id: 1, title: "Tidal light", color: .teal), Artwork(id: 2, title: "Afterglow", color: .orange), Artwork(id: 3, title: "In bloom", color: .pink)]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Studies in light").font(.system(.largeTitle, design: .serif))
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 18)], spacing: 24) {
                    ForEach(works) { work in
                        Button { selected = work } label: {
                            VStack(alignment: .leading, spacing: 12) {
                                artwork(work).aspectRatio(0.8, contentMode: .fit).clipShape(.rect(cornerRadius: 22))
                                    .matchedTransitionSource(id: work.id, in: gallery)
                                Text(work.title).font(.headline).foregroundStyle(.primary)
                            }
                        }.buttonStyle(.plain)
                    }
                }
                Text("Original vector artwork").font(.footnote).foregroundStyle(.secondary)
            }.padding(24).frame(maxWidth: 1000).frame(maxWidth: .infinity)
        }
        .navigationTitle("Gallery").navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(item: $selected) { work in
            NavigationStack {
                artwork(work).padding(24).background(Color(uiColor: .systemBackground))
                    .navigationTitle(work.title).navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { selected = nil } } }
            }.navigationTransition(.zoom(sourceID: work.id, in: gallery))
        }
        .accessibilityIdentifier("capture-ready")
    }
    private func artwork(_ work: Artwork) -> some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle().fill(work.color.gradient)
                Circle().fill(.white.opacity(0.55)).frame(width: proxy.size.width * 0.45)
                    .offset(x: proxy.size.width * 0.18, y: -proxy.size.height * 0.18)
                Ellipse().fill(.black.opacity(0.16)).frame(width: proxy.size.width * 1.7, height: proxy.size.height * 0.7)
                    .offset(y: proxy.size.height * 0.4)
            }.frame(maxWidth: .infinity, maxHeight: .infinity).clipped()
        }
    }
    private struct Artwork: Identifiable { let id: Int; let title: String; let color: Color }
}
#Preview { NavigationStack { ArtworkGalleryTransitionDemo() } }
