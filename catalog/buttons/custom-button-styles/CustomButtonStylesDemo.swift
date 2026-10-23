import SwiftUI

struct CustomButtonStylesDemo: View {
    @State private var favorite = false
    @State private var enabled = true
    @State private var saves = 0

    var body: some View {
        Form {
            Section {
                VStack(spacing: 24) {
                    Image(systemName: "leaf.fill").font(.system(size: 56)).foregroundStyle(.green)
                    Text("Keep the good things close").font(.title2.bold()).multilineTextAlignment(.center)
                    Button { favorite.toggle() } label: {
                        Label(favorite ? "Favorite" : "Add to favorites", systemImage: favorite ? "heart.fill" : "heart")
                    }
                    .buttonStyle(AtlasSoftButtonStyle()).tint(.pink).disabled(!enabled)
                    Button { saves += 1 } label: {
                        Label("Save reference", systemImage: "bookmark").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(AtlasSoftButtonStyle()).tint(.green).disabled(!enabled)
                }.padding(.vertical, 24).frame(maxWidth: .infinity)
            }
            Section {
                Toggle("Actions enabled", isOn: $enabled)
                LabeledContent("Saved references", value: String(saves))
            }
        }
        .navigationTitle("Custom button styles")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct AtlasSoftButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.horizontal, 24).frame(minHeight: 52)
            .foregroundStyle(.tint)
            .background(.tint.opacity(configuration.isPressed ? 0.24 : 0.12), in: Capsule())
            .contentShape(Capsule())
            .opacity(isEnabled ? 1 : 0.4)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.97 : 1)
            .animation(reduceMotion ? nil : .snappy(duration: 0.18), value: configuration.isPressed)
    }
}

#Preview { NavigationStack { CustomButtonStylesDemo() } }
