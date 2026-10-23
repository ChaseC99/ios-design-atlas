import SwiftUI

struct GridDetailTransitionsDemo: View {
    @Namespace private var artworkNamespace
    private let titles = ["First light", "Open water", "After dark", "Higher ground", "Slow days", "Passing clouds"]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 22) {
                ForEach(titles.indices, id: \.self) { index in
                    NavigationLink {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                artwork(index).frame(height: 360).clipShape(.rect(cornerRadius: 28))
                                Text(titles[index]).font(.system(.largeTitle, design: .serif).bold())
                                Text("An original symbol study from the Atlas collection.").font(.title3).foregroundStyle(.secondary)
                                Text("A little invitation to notice the familiar in a different way.")
                            }.padding(24)
                        }
                        .navigationTitle(titles[index]).navigationBarTitleDisplayMode(.inline)
                        .navigationTransition(.zoom(sourceID: index, in: artworkNamespace))
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            artwork(index).frame(height: 180).clipShape(.rect(cornerRadius: 20))
                                .matchedTransitionSource(id: index, in: artworkNamespace)
                            Text(titles[index]).font(.subheadline.weight(.medium)).foregroundStyle(.primary)
                        }
                    }.buttonStyle(.plain)
                }
            }.padding(20)
        }
        .navigationTitle("The collection")
        .accessibilityIdentifier("capture-ready")
    }
    private func artwork(_ index: Int) -> some View {
        ZStack {
            Rectangle().fill([Color.orange, .teal, .indigo, .brown, .green, .blue][index].gradient)
            Image(systemName: ["sun.horizon.fill", "water.waves", "moon.stars.fill", "mountain.2.fill", "leaf.fill", "cloud.sun.fill"][index])
                .font(.system(size: 65)).foregroundStyle(.white.opacity(0.85))
        }
    }
}

#Preview { NavigationStack { GridDetailTransitionsDemo() } }
