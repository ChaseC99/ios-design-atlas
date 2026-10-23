import SwiftUI

struct FormattedTextInputDemo: View {
    private enum Field { case amount, quantity, phone, code }
    @State private var amount = 24.50
    @State private var quantity = 2
    @State private var phone = ""
    @State private var code = ""
    @FocusState private var field: Field?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Form {
            Section("A little weekend budget") {
                LabeledContent("Amount") {
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad).multilineTextAlignment(.trailing).focused($field, equals: .amount)
                        .accessibilityIdentifier("capture-focus")
                }
                LabeledContent("People") {
                    TextField("People", value: $quantity, format: .number).keyboardType(.numberPad).multilineTextAlignment(.trailing).focused($field, equals: .quantity)
                }
            }
            Section {
                TextField("Phone number", text: $phone).keyboardType(.phonePad).textContentType(.telephoneNumber).focused($field, equals: .phone)
                TextField("One-time code", text: $code).keyboardType(.numberPad).textContentType(.oneTimeCode).focused($field, equals: .code)
                    .textInputAutocapitalization(.never).autocorrectionDisabled()
            } header: { Text("Contact and verification") } footer: { Text("The sample code stays on this screen; no verification request is sent.") }
            Section { LabeledContent("Formatted total", value: amount.formatted(.currency(code: "USD"))) }
        }
        .navigationTitle("Input types").navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItemGroup(placement: .keyboard) { Spacer(); Button("Done") { field = nil } } }
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); field = .amount } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { FormattedTextInputDemo() } }
