import SwiftUI

struct ArtworkComparisonSliderDemo: View {
    @State private var reveal = 0.5
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("One place. Two moods.").font(.system(.largeTitle, design: .serif))
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    artwork(evening: true, size: proxy.size)
                    artwork(evening: false, size: proxy.size)
                        .mask(alignment: .leading) { Rectangle().frame(width: proxy.size.width * reveal) }
                    Rectangle().fill(.white).frame(width: 2).offset(x: proxy.size.width * reveal - 1)
                    Image(systemName: "arrow.left.and.right").font(.headline)
                        .frame(width: 44, height: 44).foregroundStyle(.primary).background(.regularMaterial, in: Circle())
                        .position(x: proxy.size.width * reveal, y: proxy.size.height / 2)
                    HStack {
                        Text("Morning").padding(10).background(.black.opacity(0.25), in: Capsule())
                        Spacer()
                        Text("Evening").padding(10).background(.black.opacity(0.25), in: Capsule())
                    }.font(.caption.weight(.semibold)).foregroundStyle(.white).padding(16)
                        .frame(maxHeight: .infinity, alignment: .top)
                }
                .frame(width: proxy.size.width, height: proxy.size.height).clipShape(.rect(cornerRadius: 28))
                .contentShape(Rectangle())
                .gesture(DragGesture(minimumDistance: 0).onChanged { reveal = min(1, max(0, $0.location.x / proxy.size.width)) })
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Artwork comparison")
                .accessibilityValue("\(Int(reveal * 100)) percent morning")
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: reveal = min(1, reveal + 0.1)
                    case .decrement: reveal = max(0, reveal - 0.1)
                    @unknown default: break
                    }
                }
            }.aspectRatio(0.85, contentMode: .fit)
            Slider(value: $reveal, in: 0...1) { Text("Morning reveal") }
            HStack { Text("Original vector artwork"); Spacer(); Text("\(Int(reveal * 100))% morning").monospacedDigit() }
                .font(.caption).foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }.padding(24).frame(maxWidth: 700).frame(maxWidth: .infinity)
        .navigationTitle("Light studies").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func artwork(evening: Bool, size: CGSize) -> some View {
        ZStack {
            LinearGradient(colors: evening ? [.indigo, .purple, .orange] : [.cyan, .teal], startPoint: .top, endPoint: .bottom)
            Circle().fill(evening ? Color.orange : Color.white.opacity(0.8))
                .frame(width: size.width * 0.3, height: size.width * 0.3).offset(x: size.width * 0.16, y: -size.height * 0.2)
            Ellipse().fill(evening ? Color.indigo : Color.teal)
                .frame(width: size.width * 1.8, height: size.height * 0.7).offset(x: -size.width * 0.2, y: size.height * 0.4)
            Ellipse().fill(evening ? Color.black.opacity(0.2) : Color.blue.opacity(0.35))
                .frame(width: size.width * 1.6, height: size.height * 0.6).offset(x: size.width * 0.4, y: size.height * 0.5)
        }.frame(width: size.width, height: size.height).clipped()
    }
}
#Preview { NavigationStack { ArtworkComparisonSliderDemo() } }
