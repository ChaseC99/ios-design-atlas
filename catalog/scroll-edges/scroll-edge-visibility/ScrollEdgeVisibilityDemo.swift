import SwiftUI

@available(iOS 26.0, *)
struct ScrollEdgeVisibilityDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var hidden = false
    @State private var horizontal = false
    var body: some View {
        VStack(spacing: 0) {
            if !capturing {
                HStack {
                    Toggle("Hide effects", isOn: $hidden)
                    Toggle("Horizontal", isOn: $horizontal)
                }.font(.subheadline).padding()
            }
            if horizontal {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(0..<16) { index in panel(index).frame(width: 230) }
                    }.padding(20)
                }
                .scrollEdgeEffectStyle(.soft, for: .horizontal)
                .scrollEdgeEffectHidden(hidden, for: .horizontal)
                .safeAreaBar(edge: .leading) { Image(systemName: "chevron.left").padding() }
                .safeAreaBar(edge: .trailing) { Image(systemName: "chevron.right").padding() }
            } else {
                ScrollView {
                    LazyVStack(spacing: 16, pinnedViews: [.sectionHeaders]) {
                        ForEach(0..<4) { section in
                            Section {
                                ForEach(0..<3) { item in panel(section * 3 + item).frame(height: 190) }
                            } header: {
                                Text(["Dawn", "Daylight", "Dusk", "Night"][section])
                                    .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                                    .padding().background(.regularMaterial)
                            }
                        }
                    }.padding(.horizontal, 20)
                }
                .scrollEdgeEffectStyle(.soft, for: .vertical)
                .scrollEdgeEffectHidden(hidden, for: .vertical)
                .safeAreaBar(edge: .bottom) {
                    Label("12 studies", systemImage: "rectangle.stack").padding()
                }
            }
        }
        .navigationTitle("Light studies").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func panel(_ index: Int) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [.indigo, .purple.opacity(0.45), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle().fill(.white.opacity(0.3)).frame(width: 130).offset(x: 150, y: -70)
            Text("Study \(index + 1)").font(.title2.bold()).foregroundStyle(.white).padding(24)
        }.clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { ScrollEdgeVisibilityDemo() } } }
