import SwiftUI

@available(iOS 26.0, *)
struct GlassMorphingDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var namespace
    @State private var expanded = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var saved = false
    @State private var liked = false
    var body: some View {
        ZStack {
            GlassMorphingDemoBackdrop()
            GlassEffectContainer(spacing: 24) {
                HStack(spacing: 16) {
                    if expanded {
                        Button { saved.toggle() } label: {
                            Image(systemName: saved ? "bookmark.fill" : "bookmark").font(.title2).frame(width: 64, height: 64)
                        }
                        .buttonStyle(.plain).glassEffect(.regular.interactive(), in: Circle())
                        .glassEffectID("save", in: namespace)
                        .glassEffectTransition(reduceMotion ? .identity : .matchedGeometry)
                        .accessibilityLabel(saved ? "Unsave" : "Save")
                        Button { liked.toggle() } label: {
                            Image(systemName: liked ? "heart.fill" : "heart").font(.title2).frame(width: 64, height: 64)
                        }
                        .buttonStyle(.plain).glassEffect(.regular.interactive(), in: Circle())
                        .glassEffectID("like", in: namespace)
                        .glassEffectTransition(reduceMotion ? .identity : .matchedGeometry)
                        .accessibilityLabel(liked ? "Unlike" : "Like")
                    }
                    Button {
                        withAnimation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.75)) { expanded.toggle() }
                    } label: {
                        Image(systemName: expanded ? "xmark" : "plus").font(.title2).frame(width: 64, height: 64)
                    }
                    .buttonStyle(.plain).glassEffect(.regular.tint(.teal).interactive(), in: Circle())
                    .glassEffectID("expand", in: namespace)
                    .accessibilityLabel(expanded ? "Close actions" : "Show actions")
                }
            }
        }
        .navigationTitle("Glass morphing").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct GlassMorphingDemoBackdrop: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(colors: [.indigo, .blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle().fill(.orange.gradient).frame(width: geometry.size.width * 0.85)
                    .offset(x: geometry.size.width * 0.25, y: -geometry.size.height * 0.16)
                Circle().fill(.mint.opacity(0.65)).frame(width: geometry.size.width * 1.1)
                    .offset(x: -geometry.size.width * 0.25, y: geometry.size.height * 0.34)
            }.frame(width: geometry.size.width, height: geometry.size.height).clipped()
        }.ignoresSafeArea().accessibilityHidden(true)
    }
}

#Preview { if #available(iOS 26.0, *) { NavigationStack { GlassMorphingDemo() } } }
