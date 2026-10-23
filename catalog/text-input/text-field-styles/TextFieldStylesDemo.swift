import SwiftUI

struct TextFieldStylesDemo: View {
    private enum Field { case name, title, location }
    @State private var name = "Avery Morgan"
    @State private var title = "A slower weekend"
    @State private var location = ""
    @FocusState private var focused: Field?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Form {
            Section("Profile") {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Display name").font(.caption).foregroundStyle(.secondary)
                    TextField("Your name", text: $name).textContentType(.name)
                        .focused($focused, equals: .name).accessibilityIdentifier("capture-focus")
                }.padding(.vertical, 6)
            }
            Section("Rounded border") {
                TextField("Collection title", text: $title).focused($focused, equals: .title).textFieldStyle(.roundedBorder).padding(.vertical, 6)
            }
            Section("With an accessory") {
                HStack {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(.secondary)
                    TextField("Add a place", text: $location).focused($focused, equals: .location)
                    if !location.isEmpty {
                        Button("Clear place", systemImage: "xmark.circle.fill") { location = "" }
                            .labelStyle(.iconOnly).foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("A little about you")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItemGroup(placement: .keyboard) { Spacer(); Button("Done") { focused = nil } } }
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focused = .name } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { TextFieldStylesDemo() } }
