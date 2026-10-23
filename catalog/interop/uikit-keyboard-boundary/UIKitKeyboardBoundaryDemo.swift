import SwiftUI
import UIKit

struct UIKitKeyboardBoundaryDemo: View {
    @State private var message = "Let’s take the coastal path."
    @State private var sent = "A little more time outside."
    var body: some View {
        ComposerController(message: $message, sent: $sent)
            .ignoresSafeArea(.keyboard)
            .navigationTitle("A small plan").navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier("capture-ready")
    }
    private struct ComposerController: UIViewControllerRepresentable {
        @Binding var message: String
        @Binding var sent: String
        func makeUIViewController(context: Context) -> Controller { Controller() }
        func updateUIViewController(_ controller: Controller, context: Context) {
            controller.configure(message: message, sent: sent, onChange: { message = $0 }, onSend: { sent = $0; message = "" })
        }
        static func dismantleUIViewController(_ controller: Controller, coordinator: ()) { controller.focusTask?.cancel() }
    }
    private struct MessageCard: View {
        let sent: String
        var body: some View {
            VStack(alignment: .leading, spacing: 18) {
                Image(systemName: "sun.horizon").font(.largeTitle).foregroundStyle(.teal)
                Text("A weekend without a rush.").font(.system(.title2, design: .serif).bold())
                Text(sent).foregroundStyle(.secondary)
            }.padding(24).frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(uiColor: .secondarySystemGroupedBackground), in: .rect(cornerRadius: 20))
        }
    }
    private final class Controller: UIViewController, UITextFieldDelegate {
        let field = UITextField()
        var focusTask: Task<Void, Never>?
        private var onChange: (String) -> Void = { _ in }
        private var onSend: (String) -> Void = { _ in }
        private var pendingMessage = ""
        private var pendingSent = ""
        private var host: UIHostingController<MessageCard>?
        override func viewDidLoad() {
            super.viewDidLoad(); view.backgroundColor = .systemGroupedBackground
            let hosting = UIHostingController(rootView: MessageCard(sent: pendingSent)); host = hosting
            hosting.view.backgroundColor = .clear; hosting.view.translatesAutoresizingMaskIntoConstraints = false
            addChild(hosting); view.addSubview(hosting.view); hosting.didMove(toParent: self)
            field.borderStyle = .roundedRect; field.placeholder = "Write a message"; field.text = pendingMessage
            field.accessibilityIdentifier = "capture-focus"; field.accessibilityLabel = "Message"
            field.returnKeyType = .send; field.delegate = self
            field.addTarget(self, action: #selector(changed), for: .editingChanged)
            let send = UIButton(configuration: .filled(), primaryAction: UIAction(title: "Send") { [weak self] _ in self?.submit() })
            field.setContentHuggingPriority(.defaultLow, for: .horizontal); send.setContentHuggingPriority(.required, for: .horizontal)
            let bar = UIStackView(arrangedSubviews: [field, send]); bar.spacing = 10; bar.alignment = .fill
            bar.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(bar)
            NSLayoutConstraint.activate([
                hosting.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), hosting.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24), hosting.view.heightAnchor.constraint(equalToConstant: 210),
                bar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), bar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), bar.heightAnchor.constraint(equalToConstant: 44), bar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -16)
            ])
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if ProcessInfo.processInfo.arguments.contains("--capture") {
                focusTask = Task { [weak self] in
                    do { try await Task.sleep(for: .milliseconds(450)) } catch { return }
                    guard let self, self.view.window != nil else { return }; self.field.becomeFirstResponder()
                }
            }
        }
        func configure(message: String, sent: String, onChange: @escaping (String) -> Void, onSend: @escaping (String) -> Void) {
            pendingMessage = message; pendingSent = sent; self.onChange = onChange; self.onSend = onSend
            if field.text != message { field.text = message }
            host?.rootView = MessageCard(sent: sent)
        }
        @objc private func changed() { onChange(field.text ?? "") }
        private func submit() {
            let value = (field.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !value.isEmpty else { return }; onSend(value); field.resignFirstResponder()
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool { submit(); return false }
    }
}

#Preview { NavigationStack { UIKitKeyboardBoundaryDemo() } }
