import SwiftUI

struct CardCarouselsDemo: View {
    @State private var current: Int? = 0
    @State private var paging = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Make a little time.").font(.system(.largeTitle, design: .serif).weight(.semibold))
                    Text("Places for a slower weekend.").foregroundStyle(.secondary)
                }.padding(.horizontal, 24).padding(.top, 12)
                if paging {
                    carousel.scrollTargetBehavior(.paging)
                } else {
                    carousel.scrollTargetBehavior(.viewAligned)
                }
                HStack(spacing: 7) {
                    ForEach(0..<5) { index in
                        Button { withAnimation { current = index } } label: {
                            Capsule().fill(current == index ? Color.primary : Color.secondary.opacity(0.25))
                                .frame(width: current == index ? 22 : 7, height: 7)
                        }.accessibilityLabel("Card \(index + 1)").accessibilityAddTraits(current == index ? .isSelected : [])
                    }
                }.frame(maxWidth: .infinity)
                if !isCapturing {
                    Toggle("Full-width paging", isOn: $paging).padding(.horizontal, 24)
                }
            }.padding(.bottom, 24)
        }
        .navigationTitle("Discover")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var carousel: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: paging ? 0 : 16) {
                ForEach(0..<5) { index in
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            Rectangle().fill([Color.teal, .indigo, .orange, .blue, .brown][index].gradient)
                            Image(systemName: ["water.waves", "moon.stars", "sun.horizon", "cloud.sun", "mountain.2"][index])
                                .font(.system(size: 90)).foregroundStyle(.white.opacity(0.9))
                        }.frame(height: 280)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(["By the water", "After the city sleeps", "The first light", "Under open skies", "A wider perspective"][index]).font(.title2.bold())
                            Text("A FIELD GUIDE · \(index + 3) PLACES").font(.caption.weight(.medium)).foregroundStyle(.secondary)
                            Text("Follow the path a little further. There is more to notice when you slow down.").font(.subheadline).foregroundStyle(.secondary)
                        }.padding(22)
                    }
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .clipShape(.rect(cornerRadius: 26))
                    .containerRelativeFrame(.horizontal) { width, _ in paging ? width : width * 0.84 }
                    .id(index)
                }
            }.scrollTargetLayout()
        }
        .contentMargins(.horizontal, paging ? 0 : 24, for: .scrollContent)
        .scrollIndicators(.hidden)
        .scrollPosition(id: $current)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview { NavigationStack { CardCarouselsDemo() } }
