import SwiftUI
import UIKit

struct UIKitSwiftUIControlsDemo: View {
    @State private var enabled = true
    @State private var level: Float = 0.6
    @State private var choice = 1
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("One set of preferences.").font(.system(.title, design: .serif).bold())
                VStack(alignment: .leading, spacing: 18) {
                    Text("SwiftUI").font(.headline)
                    Toggle("Reminders", isOn: $enabled)
                    Slider(value: $level) { Text("Sound level") }
                    Picker("Frequency", selection: $choice) { Text("Daily").tag(0); Text("Weekly").tag(1); Text("Monthly").tag(2) }.pickerStyle(.segmented)
                }.padding(20).background(.background, in: .rect(cornerRadius: 20))
                VStack(alignment: .leading, spacing: 18) {
                    Text("UIKit").font(.headline)
                    NativePreferences(enabled: $enabled, level: $level, choice: $choice).frame(height: 140)
                }.padding(20).background(.background, in: .rect(cornerRadius: 20))
                Text("Shared level: \(Int(level * 100))%").font(.subheadline).foregroundStyle(.secondary)
            }.padding(24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Two frameworks").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct NativePreferences: UIViewRepresentable {
        @Binding var enabled: Bool
        @Binding var level: Float
        @Binding var choice: Int
        func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
        func makeUIView(context: Context) -> Panel {
            let panel = Panel()
            panel.toggle.addTarget(context.coordinator, action: #selector(Coordinator.toggleChanged(_:)), for: .valueChanged)
            panel.slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderChanged(_:)), for: .valueChanged)
            panel.segment.addTarget(context.coordinator, action: #selector(Coordinator.segmentChanged(_:)), for: .valueChanged)
            return panel
        }
        func updateUIView(_ panel: Panel, context: Context) {
            context.coordinator.parent = self
            panel.toggle.isOn = enabled; panel.slider.value = level; panel.segment.selectedSegmentIndex = choice
        }
        @MainActor final class Coordinator: NSObject {
            var parent: NativePreferences
            init(parent: NativePreferences) { self.parent = parent }
            @objc func toggleChanged(_ sender: UISwitch) { parent.enabled = sender.isOn }
            @objc func sliderChanged(_ sender: UISlider) { parent.level = sender.value }
            @objc func segmentChanged(_ sender: UISegmentedControl) { parent.choice = sender.selectedSegmentIndex }
        }
        final class Panel: UIView {
            let toggle = UISwitch(); let slider = UISlider(); let segment = UISegmentedControl(items: ["Daily", "Weekly", "Monthly"])
            override init(frame: CGRect) {
                super.init(frame: frame)
                let title = UILabel(); title.text = "Reminders"; title.font = .preferredFont(forTextStyle: .body); title.adjustsFontForContentSizeCategory = true
                toggle.accessibilityLabel = "Reminders"; slider.accessibilityLabel = "Sound level"; segment.accessibilityLabel = "Frequency"
                toggle.setContentHuggingPriority(.required, for: .horizontal)
                let row = UIStackView(arrangedSubviews: [title, toggle]); row.alignment = .center
                let stack = UIStackView(arrangedSubviews: [row, slider, segment]); stack.axis = .vertical; stack.spacing = 16; stack.distribution = .equalSpacing
                stack.translatesAutoresizingMaskIntoConstraints = false; addSubview(stack)
                NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor), stack.trailingAnchor.constraint(equalTo: trailingAnchor), stack.topAnchor.constraint(equalTo: topAnchor), stack.bottomAnchor.constraint(equalTo: bottomAnchor)])
            }
            required init?(coder: NSCoder) { fatalError("init(coder:) is not used") }
        }
    }
}

#Preview { NavigationStack { UIKitSwiftUIControlsDemo() } }
