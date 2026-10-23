import SwiftUI

struct ChoiceChipsDemo: View {
    @State private var allowsMultiple = true
    @State private var selected: Set<String> = ["Coast", "Forest"]
    @State private var longLabels = false
    private let choices = ["Coast", "Forest", "City", "Mountains", "Lakes", "Gardens"]
    private func choose(_ option: String) {
        if allowsMultiple {
            if selected.contains(option) { selected.remove(option) }
            else { selected.insert(option) }
        } else { selected = [option] }
    }
    var body: some View {
        Form {
            Section("Where would you like to go?") {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 12) {
                    ForEach(choices, id: \.self) { option in
                        let isSelected = selected.contains(option)
                        Button { choose(option) } label: {
                            Label(longLabels ? "Explore the \(option.lowercased())" : option,
                                  systemImage: isSelected ? "checkmark.circle.fill" : "circle")
                                .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                        }
                        .buttonStyle(.bordered)
                        .tint(isSelected ? .teal : .secondary)
                        .accessibilityAddTraits(isSelected ? .isSelected : [])
                    }
                }.padding(.vertical, 8)
            }
            Section("Selection") {
                Toggle("Allow multiple choices", isOn: $allowsMultiple)
                Toggle("Long labels", isOn: $longLabels)
                Text(selected.sorted().joined(separator: ", ")).foregroundStyle(.secondary)
            }
        }
        .onChange(of: allowsMultiple) { _, multiple in
            if !multiple { selected = [choices.first(where: { selected.contains($0) }) ?? choices[0]] }
        }
        .navigationTitle("Single and multiple choices")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ChoiceChipsDemo() } }
