import SwiftUI

struct SystemMaterialsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var dark = false
    private let names = ["Ultra thin", "Thin", "Regular", "Thick", "Ultra thick"]
    private let materials: [Material] = [.ultraThin, .thin, .regular, .thick, .ultraThick]
    var body: some View {
        ZStack {
            SystemMaterialsDemoBackdrop()
            ScrollView {
                VStack(spacing: 16) {
                    if !capturing {
                        Toggle("Dark appearance", isOn: $dark).padding(18).background(.regularMaterial, in: Capsule())
                    }
                    ForEach(0..<5) { index in
                        HStack {
                            Text(names[index]).font(.title3.weight(.medium))
                            Spacer()
                            Image(systemName: "square.on.square").font(.title2)
                        }.padding(24).frame(minHeight: 84)
                            .background(materials[index], in: RoundedRectangle(cornerRadius: 26))
                    }
                }.padding(24).padding(.vertical, 28)
            }
        }
        .environment(\.colorScheme, dark ? .dark : .light)
        .navigationTitle("Materials").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct SystemMaterialsDemoBackdrop: View {
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

#Preview { NavigationStack { SystemMaterialsDemo() } }
