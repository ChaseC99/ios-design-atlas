import SwiftUI

struct PopoverContentDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var mode = "List"
    @State private var selected = "Personal"
    @State private var notifications = true

    var body: some View {
        Group {
            if isCapturing {
                trigger
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(uiColor: .systemBackground).ignoresSafeArea())
            } else {
                Form {
                    Section("Content") {
                        Picker("Container", selection: $mode) {
                            Text("List").tag("List")
                            Text("Form").tag("Form")
                        }.pickerStyle(.segmented)
                        LabeledContent("Collection", value: selected)
                    }
                    Section { trigger }
                    Section("Try it") {
                        Text("Push into a collection, go back, then switch to the form example. Editing controls and navigation live inside a real popover.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Popover content")
        .navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { isPresented = true } }
    }

    private var trigger: some View {
        Button("Collection options", systemImage: "folder") { isPresented = true }
            .accessibilityIdentifier("present")
            .popover(isPresented: $isPresented) {
                NavigationStack {
                    Group {
                        if mode == "List" {
                            List(["Personal", "Work", "Saved for later"], id: \.self) { item in
                                NavigationLink {
                                    Form {
                                        Text("Use \(item) to keep related references together.")
                                        Button("Choose this collection") {
                                            selected = item
                                            isPresented = false
                                        }
                                    }.navigationTitle(item)
                                } label: {
                                    Label(item, systemImage: "folder")
                                }
                            }
                        } else {
                            Form {
                                TextField("Collection", text: $selected)
                                Toggle("Notify me about changes", isOn: $notifications)
                            }
                        }
                    }
                    .navigationTitle("Collections")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { isPresented = false }
                        }
                    }
                }
                .frame(width: 320, height: 380)
                .presentationCompactAdaptation(.popover)
                .accessibilityIdentifier("capture-ready")
            }
    }
}

#Preview { NavigationStack { PopoverContentDemo() } }
