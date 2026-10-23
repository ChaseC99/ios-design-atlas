import SwiftUI
import UIKit

struct UIViewBindingBridgeDemo: View {
    @State private var volume: Float = 0.65
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Image(systemName: "waveform").font(.system(size: 60)).foregroundStyle(.indigo).padding(.top, 28)
            Text("Find your level.").font(.system(.largeTitle, design: .serif).bold())
            Text("\(Int(volume * 100))%").font(.system(size: 64, weight: .light, design: .rounded)).monospacedDigit()
            VStack(alignment: .leading, spacing: 12) {
                Label("UIKit slider", systemImage: "slider.horizontal.3").font(.headline)
                BoundSlider(value: $volume).frame(height: 44)
            }
            HStack {
                Button("Quiet") { volume = 0.2 }
                Button("Balanced") { volume = 0.5 }
                Button("Full") { volume = 1 }
            }.buttonStyle(.bordered)
            Text("The slider and these SwiftUI buttons share one value.").font(.subheadline).foregroundStyle(.secondary)
            Spacer()
        }.padding(28)
        .navigationTitle("A shared value").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct BoundSlider: UIViewRepresentable {
        @Binding var value: Float
        func makeCoordinator() -> Coordinator { Coordinator(value: $value) }
        func makeUIView(context: Context) -> UISlider {
            let slider = UISlider()
            slider.minimumValue = 0; slider.maximumValue = 1
            slider.accessibilityLabel = "Listening volume"
            slider.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
            return slider
        }
        func updateUIView(_ slider: UISlider, context: Context) {
            context.coordinator.value = $value
            if slider.value != value { slider.setValue(value, animated: false) }
        }
        static func dismantleUIView(_ slider: UISlider, coordinator: Coordinator) {
            slider.removeTarget(coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        }
        @MainActor final class Coordinator: NSObject {
            var value: Binding<Float>
            init(value: Binding<Float>) { self.value = value }
            @objc func changed(_ sender: UISlider) { value.wrappedValue = sender.value }
        }
    }
}

#Preview { NavigationStack { UIViewBindingBridgeDemo() } }
