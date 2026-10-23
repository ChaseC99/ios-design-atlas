import SwiftUI

struct SheetNavigationDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Button("Edit weekend collection") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Navigation and nested sheets")
        .sheet(isPresented: $isPresented) {
            WeekendCollectionSheet()
                .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

private struct WeekendCollectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isChoosingFolder = false
    @State private var folder = "Personal"

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label("Weekend references", systemImage: "leaf.fill")
                        .font(.headline).foregroundStyle(.green)
                }
                Section {
                    NavigationLink {
                        Form {
                            LabeledContent("Name", value: "Weekend references")
                            LabeledContent("Items", value: "12")
                            Text("Quiet places and small discoveries for the days ahead.")
                        }.navigationTitle("Details")
                    } label: {
                        Label("Collection details", systemImage: "info.circle")
                    }
                    Button { isChoosingFolder = true } label: {
                        LabeledContent("Move to folder", value: folder)
                    }
                }
            }
            .navigationTitle("Edit collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { Button("Done") { dismiss() } }
            .sheet(isPresented: $isChoosingFolder) {
                NavigationStack {
                    List(["Personal", "Travel", "Shared"], id: \.self) { choice in
                        Button {
                            folder = choice
                            isChoosingFolder = false
                        } label: {
                            HStack {
                                Label(choice, systemImage: "folder")
                                Spacer()
                                if choice == folder { Image(systemName: "checkmark") }
                            }
                        }
                    }
                    .navigationTitle("Move to folder")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { Button("Cancel") { isChoosingFolder = false } }
                }.presentationDetents([.medium])
            }
        }
    }
}

#Preview { NavigationStack { SheetNavigationDemo() } }
