import SwiftUI

struct ViewTransitionsDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var visible = true
    @State private var style = "Asymmetric"
    @State private var previewReducedMotion = false
    private var reducesMotion: Bool { reduceMotion || previewReducedMotion }
    private var transition: AnyTransition {
        if reducesMotion { return .opacity }
        switch style {
        case "Fade": return .opacity
        case "Scale": return .scale(scale: 0.85).combined(with: .opacity)
        case "Slide": return .move(edge: .trailing).combined(with: .opacity)
        default: return .asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .scale(scale: 0.85).combined(with: .opacity))
        }
    }
    var body: some View {
        Form {
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 24).fill(.secondary.opacity(0.05))
                    if visible {
                        VStack(alignment: .leading, spacing: 18) {
                            Image(systemName: "bookmark.fill").font(.largeTitle).foregroundStyle(.teal)
                            Text("Saved for a slower day").font(.title2.bold())
                            Text("The coastal path is waiting.").foregroundStyle(.secondary)
                        }
                        .padding(24).frame(maxWidth: .infinity, alignment: .leading)
                        .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 24))
                        .transition(transition)
                    }
                }.frame(height: 220).clipped()
                Button(visible ? "Remove card" : "Insert card") {
                    withAnimation(reducesMotion ? .easeInOut(duration: 0.15) : .spring(duration: 0.45)) {
                        visible.toggle()
                    }
                }.buttonStyle(.borderedProminent)
            }
            Section("Transition") {
                Picker("Style", selection: $style) {
                    ForEach(["Asymmetric", "Fade", "Scale", "Slide"], id: \.self) { Text($0) }
                }
                Toggle("Preview reduced motion", isOn: $previewReducedMotion)
            }
        }
        .navigationTitle("Insertion and removal transitions")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ViewTransitionsDemo() } }
