import SwiftUI

struct RepeatingButtonsDemo: View {
    @State private var servings = 2
    @State private var repeating = true
    var body: some View {
        Form {
            Section {
                VStack(spacing: 24) {
                    Image(systemName: "cup.and.saucer.fill").font(.system(size: 48)).foregroundStyle(.brown)
                    Text("Coffee for the table").font(.title2.bold())
                    HStack(spacing: 28) {
                        Button("Fewer servings", systemImage: "minus") { servings -= 1 }
                            .disabled(servings <= 1)
                        Text(servings, format: .number).font(.largeTitle.bold()).monospacedDigit()
                            .accessibilityLabel("Servings").accessibilityValue(String(servings))
                        Button("More servings", systemImage: "plus") { servings += 1 }
                            .disabled(servings >= 12)
                    }
                    .labelStyle(.iconOnly).buttonStyle(.bordered).controlSize(.large)
                    .buttonRepeatBehavior(repeating ? .enabled : .disabled)
                    Text("\(servings * 18) g coffee · \(servings * 300) ml water")
                        .foregroundStyle(.secondary).monospacedDigit()
                }.frame(maxWidth: .infinity).padding(.vertical, 20)
            }
            Section {
                Toggle("Repeat while held", isOn: $repeating)
                Button("Reset servings") { servings = 2 }
            }
        }
        .navigationTitle("Repeating buttons")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { RepeatingButtonsDemo() } }
