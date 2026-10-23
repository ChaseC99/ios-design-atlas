import SwiftUI

struct SheetBasicsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var sizing = "Automatic"
    @State private var name = "Weekend references"
    @State private var isShared = false

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Picker("Sizing", selection: $sizing) {
                        ForEach(["Automatic", "Form", "Page"], id: \.self) { Text($0) }
                    }
                    Button("New collection") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Default sheets")
        .sheet(isPresented: $isPresented) {
            switch sizing {
            case "Form": editor.presentationSizing(.form)
            case "Page": editor.presentationSizing(.page)
            default: editor
            }
        }
        .task { if isCapturing { isPresented = true } }
    }

    private var editor: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    Label("Choose a symbol", systemImage: "folder.badge.plus")
                }
                Section {
                    Toggle("Shared collection", isOn: $isShared)
                } footer: {
                    Text("Keep the references, places, and ideas you want to return to.")
                }
            }
            .navigationTitle("New collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") { isPresented = false }
                        .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SheetBasicsDemo() } }
