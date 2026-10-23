import SwiftUI

struct MultiStepSetupDemo: View {
    @State private var step = 0
    @State private var name = "A slower weekend"
    @State private var category = "Travel"
    @State private var privateCollection = true
    @State private var completed = false
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Step \(step + 1) of 3").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                ProgressView(value: Double(step + 1), total: 3).tint(.indigo)
            }.padding(24)
            if completed {
                ContentUnavailableView("Your collection is ready", systemImage: "checkmark.circle", description: Text(name))
            } else {
                Form {
                    switch step {
                    case 0:
                        Section { TextField("Collection name", text: $name) } header: { Text("Give it a name") } footer: { Text("Something that helps you find it again.") }
                        Picker("Category", selection: $category) { Text("Travel").tag("Travel"); Text("Personal").tag("Personal"); Text("Ideas").tag("Ideas") }
                    case 1:
                        Section { Toggle("Keep this collection private", isOn: $privateCollection) } footer: { Text("This sample stores its choices only on this screen.") }
                    default:
                        Section("Review") { LabeledContent("Name", value: name); LabeledContent("Category", value: category); LabeledContent("Visibility", value: privateCollection ? "Private" : "Shared") }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                if step > 0 && !completed { Button("Back") { step -= 1 }.buttonStyle(.bordered) }
                Spacer()
                Button(completed ? "Start again" : step == 2 ? "Create collection" : "Continue") {
                    if completed { completed = false; step = 0 } else if step < 2 { step += 1 } else { completed = true }
                }.buttonStyle(.borderedProminent).disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }.padding().background(.bar)
        }
        .navigationTitle("New collection").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { MultiStepSetupDemo() } }
