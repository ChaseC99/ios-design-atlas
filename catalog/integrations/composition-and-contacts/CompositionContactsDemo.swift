import SwiftUI
import MessageUI
import ContactsUI

struct CompositionContactsDemo: View {
    private enum Destination: String, Identifiable { case mail, message, contact; var id: String { rawValue } }
    @State private var destination: Destination?
    @State private var status = "No composer opened"
    @State private var contact = "No contact selected"
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: "envelope.open.fill").font(.system(size: 52)).foregroundStyle(.teal)
                    Text("Make a plan").font(.title.bold())
                    Text("Meet at the harbor at 9. Bring a notebook and take the scenic route.").foregroundStyle(.secondary)
                }.padding(.vertical, 20)
            }
            Section("System interfaces") {
                Button("Compose email", systemImage: "envelope") { destination = .mail }.disabled(!MFMailComposeViewController.canSendMail())
                Button("Compose message", systemImage: "message") { destination = .message }.disabled(!MFMessageComposeViewController.canSendText())
                Button("Choose a contact", systemImage: "person.crop.circle") { destination = .contact }
            }
            Section {
                LabeledContent("Contact", value: contact)
                Text(status).font(.subheadline).foregroundStyle(.secondary)
                if !MFMailComposeViewController.canSendMail() { Text("Mail composition needs an available mail account on this device.").font(.caption).foregroundStyle(.secondary) }
                if !MFMessageComposeViewController.canSendText() { Text("Message composition is unavailable on this device.").font(.caption).foregroundStyle(.secondary) }
            }
        }
        .sheet(item: $destination) { item in
            switch item {
            case .mail: AtlasMailComposer { status = $0; destination = nil }
            case .message: AtlasMessageComposer { status = $0; destination = nil }
            case .contact: AtlasContactPicker { selected in
                if let selected { contact = selected; status = "Contact selected locally" } else { status = "Contact selection cancelled" }
                destination = nil
                }
            }
        }
        .navigationTitle("Composition and contacts").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
private struct AtlasMailComposer: UIViewControllerRepresentable {
    var completed: (String) -> Void
    func makeCoordinator() -> Coordinator { Coordinator(completed) }
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = context.coordinator
        controller.setSubject("Weekend plans")
        controller.setMessageBody("Meet at the harbor at 9.", isHTML: false)
        return controller
    }
    func updateUIViewController(_ controller: MFMailComposeViewController, context: Context) {}
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let completed: (String) -> Void
        init(_ completed: @escaping (String) -> Void) { self.completed = completed }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if error != nil { completed("Mail composition failed"); return }
            switch result {
            case .cancelled: completed("Mail cancelled")
            case .saved: completed("Draft saved by Mail")
            case .sent: completed("Mail handed off for sending")
            case .failed: completed("Mail could not be sent")
            @unknown default: completed("Mail composer closed")
            }
        }
    }
}
private struct AtlasMessageComposer: UIViewControllerRepresentable {
    var completed: (String) -> Void
    func makeCoordinator() -> Coordinator { Coordinator(completed) }
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.body = "Meet at the harbor at 9."
        return controller
    }
    func updateUIViewController(_ controller: MFMessageComposeViewController, context: Context) {}
    final class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let completed: (String) -> Void
        init(_ completed: @escaping (String) -> Void) { self.completed = completed }
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .cancelled: completed("Message cancelled")
            case .sent: completed("Message handed off for sending")
            case .failed: completed("Message could not be sent")
            @unknown default: completed("Message composer closed")
            }
        }
    }
}
private struct AtlasContactPicker: UIViewControllerRepresentable {
    var completed: (String?) -> Void
    func makeCoordinator() -> Coordinator { Coordinator(completed) }
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let controller = CNContactPickerViewController(); controller.delegate = context.coordinator; return controller
    }
    func updateUIViewController(_ controller: CNContactPickerViewController, context: Context) {}
    final class Coordinator: NSObject, CNContactPickerDelegate {
        let completed: (String?) -> Void
        init(_ completed: @escaping (String?) -> Void) { self.completed = completed }
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            completed(CNContactFormatter.string(from: contact, style: .fullName) ?? "Contact selected")
        }
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) { completed(nil) }
    }
}

#Preview { NavigationStack { CompositionContactsDemo() } }
