import SwiftUI

struct NavigationImageHeaderDemo: View {
    @State private var saved = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        LinearGradient(colors: [.indigo, .purple.opacity(0.7), .orange.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        Image(systemName: "mountain.2.fill")
                            .font(.system(size: 175)).foregroundStyle(.white.opacity(0.65))
                    }
                    .frame(height: 340)
                    .overlay(alignment: .bottomLeading) {
                        Text("ABOVE\nTHE EVERYDAY").font(.system(size: 34, weight: .black, design: .rounded))
                            .foregroundStyle(.white).padding(28)
                    }
                    VStack(alignment: .leading, spacing: 22) {
                        Text("A wider perspective").font(.largeTitle.bold())
                        Text("FIELD NOTES · 6 MIN READ").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                        Text("Some days call for a different view. Follow the trail until the city feels a little smaller, and the sky a little closer.").font(.title3)
                        Divider()
                        ForEach(1...5, id: \.self) { _ in
                            Text("Leave room for an unexpected turn. The best part of a journey is often the moment you stop following the plan.").foregroundStyle(.secondary)
                        }
                    }.padding(28)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(saved ? "Remove bookmark" : "Bookmark", systemImage: saved ? "bookmark.fill" : "bookmark") { saved.toggle() }
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationImageHeaderDemo() }
