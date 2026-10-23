import SwiftUI

struct SheetAdaptationDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var isPresented = false
    @State private var adaptation = "Automatic"
    @State private var packed: Set<String> = ["Notebook"]
    private let items = ["Notebook", "Water bottle", "Light jacket", "Sunglasses", "Camera"]

    private var preference: PresentationAdaptation {
        switch adaptation {
        case "Keep a sheet": .sheet
        case "Full screen": .fullScreenCover
        default: .automatic
        }
    }

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Picker("Compact adaptation", selection: $adaptation) {
                        ForEach(["Automatic", "Keep a sheet", "Full screen"], id: \.self) { Text($0) }
                    }
                    Section("Available space") {
                        LabeledContent("Width", value: horizontalSizeClass == .compact ? "Compact" : "Regular")
                        LabeledContent("Height", value: verticalSizeClass == .compact ? "Compact" : "Regular")
                    }
                    Button("Show packing list") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Compact sheet adaptation")
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                List {
                    Section {
                        ForEach(items, id: \.self) { item in
                            Button {
                                if packed.contains(item) { packed.remove(item) }
                                else { packed.insert(item) }
                            } label: {
                                Label(item, systemImage: packed.contains(item) ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(packed.contains(item) ? Color.green : Color.primary)
                            }
                        }
                    } header: {
                        Text("A day outside")
                    } footer: {
                        Text("\(packed.count) of \(items.count) packed")
                    }
                }
                .navigationTitle("The weekend kit")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { Button("Done") { isPresented = false } }
            }
            .presentationSizing(.form)
            .presentationCompactAdaptation(preference)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { SheetAdaptationDemo() } }
