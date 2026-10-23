import SwiftUI

struct ProfileEditingDemo: View {
    @State private var savedName = "Avery Morgan"
    @State private var name = "Avery Morgan"
    @State private var savedBio = "Finding a little inspiration in the everyday."
    @State private var bio = "Finding a little inspiration in the everyday."
    @State private var savedColor = Color.indigo
    @State private var color = Color.indigo
    @State private var confirmation = false
    var body: some View {
        Form {
            Section {
                VStack(spacing: 16) {
                    Text(initials).font(.system(size: 38, weight: .semibold, design: .rounded)).foregroundStyle(.white)
                        .frame(width: 112, height: 112).background(color.gradient, in: .circle).accessibilityLabel("Profile initials: \(initials)")
                    Text(savedName).font(.headline)
                }.frame(maxWidth: .infinity).padding(.vertical, 20)
            }
            Section("About you") {
                TextField("Display name", text: $name).textContentType(.name)
                TextField("A short bio · optional", text: $bio, axis: .vertical).lineLimit(2...5)
                ColorPicker("Avatar color", selection: $color, supportsOpacity: false)
            }
            if confirmation { Section { Label("Profile updated", systemImage: "checkmark.circle").foregroundStyle(.green) } }
        }
        .navigationTitle("Edit profile").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) { Button("Reset") { name = savedName; bio = savedBio; color = savedColor; confirmation = false } }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { savedName = name.trimmingCharacters(in: .whitespacesAndNewlines); savedBio = bio; savedColor = color; confirmation = true }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .onChange(of: name) { _, _ in confirmation = false }
        .onChange(of: bio) { _, _ in confirmation = false }
        .onChange(of: color) { _, _ in confirmation = false }
        .accessibilityIdentifier("capture-ready")
    }
    private var initials: String { name.split(whereSeparator: \.isWhitespace).prefix(2).compactMap(\.first).map(String.init).joined() }
}

#Preview { NavigationStack { ProfileEditingDemo() } }
