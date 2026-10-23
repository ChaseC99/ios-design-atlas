import SwiftUI

struct ConditionalValidationFormDemo: View {
    @State private var name = "Avery Morgan"
    @State private var attending = true
    @State private var guests = 1
    @State private var meal = "Vegetarian"
    @State private var dietaryNotes = ""
    @State private var inlineValidation = true
    @State private var attempted = false
    @State private var submitted = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var nameInvalid: Bool { name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    var body: some View {
        Form {
            Section("Your name · required") {
                TextField("Name", text: $name).textContentType(.name)
                if nameInvalid && (inlineValidation || attempted) { Label("Enter your name to continue", systemImage: "exclamationmark.circle").font(.footnote).foregroundStyle(.red) }
            }
            Section("Saturday gathering") {
                Toggle("I’ll be there", isOn: $attending)
                if attending {
                    Stepper("\(guests) \(guests == 1 ? "guest" : "guests")", value: $guests, in: 1...6)
                    Picker("Meal", selection: $meal) { Text("Standard").tag("Standard"); Text("Vegetarian").tag("Vegetarian"); Text("Other").tag("Other") }
                    if meal == "Other" { TextField("Dietary notes · optional", text: $dietaryNotes, axis: .vertical).lineLimit(2...4) }
                }
            }
            if !isCapturing { Section { Toggle("Validate while editing", isOn: $inlineValidation) } }
            Section { Button(submitted ? "Response saved" : "Save response") { attempted = true; submitted = !nameInvalid } }
        }
        .navigationTitle("You’re invited")
        .onChange(of: name) { _, _ in submitted = false }
        .onChange(of: attending) { _, _ in submitted = false }
        .onChange(of: guests) { _, _ in submitted = false }
        .onChange(of: meal) { _, _ in submitted = false }
        .onChange(of: dietaryNotes) { _, _ in submitted = false }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ConditionalValidationFormDemo() } }
