import SwiftUI

struct PickerStylesDemo: View {
    @State private var style = "Segmented"
    @State private var selection = "Relaxed"
    @State private var longLabels = false
    private let values = ["Relaxed", "Steady", "Brisk"]
    private var picker: some View {
        Picker("Walking pace", selection: $selection) {
            ForEach(values, id: \.self) { value in
                Text(longLabels ? "\(value) · Enjoy the scenery" : value).tag(value)
            }
        }
    }
    var body: some View {
        Form {
            Section("Walking pace") {
                switch style {
                case "Menu": picker.pickerStyle(.menu)
                case "Wheel": picker.pickerStyle(.wheel)
                case "Inline": picker.pickerStyle(.inline)
                case "Navigation": picker.pickerStyle(.navigationLink)
                default: picker.pickerStyle(.segmented)
                }
            }
            Section("Presentation") {
                Picker("Style", selection: $style) {
                    ForEach(["Segmented", "Menu", "Wheel", "Inline", "Navigation"], id: \.self) { Text($0) }
                }
                Toggle("Long option labels", isOn: $longLabels)
                LabeledContent("Selected pace", value: selection)
            }
        }
        .navigationTitle("Picker styles")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { PickerStylesDemo() } }
