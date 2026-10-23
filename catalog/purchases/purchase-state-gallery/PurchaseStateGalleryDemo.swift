import SwiftUI
import Foundation

struct PurchaseStateGalleryDemo: View {
    private enum Phase: String, CaseIterable {
        case processing = "Processing", cancelled = "Cancelled", pending = "Pending", failed = "Failed", active = "Active", expired = "Expired"
        var symbol: String {
            switch self { case .processing: "arrow.triangle.2.circlepath"; case .cancelled: "xmark.circle"; case .pending: "hourglass"; case .failed: "exclamationmark.circle"; case .active: "checkmark.seal.fill"; case .expired: "lock" }
        }
        var title: String {
            switch self { case .processing: "A moment, please."; case .cancelled: "You’re still in control."; case .pending: "Waiting for approval."; case .failed: "That didn’t go through."; case .active: "There’s room for more."; case .expired: "Your ideas are still here." }
        }
        var detail: String {
            switch self {
            case .processing: "The app is waiting for a purchase result."
            case .cancelled: "The purchase was cancelled. Your current access has not changed."
            case .pending: "Keep exploring while the purchase awaits approval."
            case .failed: "The app could not complete the purchase. Try again when you’re ready."
            case .active: "Atlas Plus features are available in this simulated state."
            case .expired: "Read your saved ideas, or choose a plan to create more collections."
            }
        }
    }
    @State private var state = Phase.pending
    @State private var featureOpen = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                Text("Simulated app state").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                if !isCapturing { Picker("Preview state", selection: $state) { ForEach(Phase.allCases, id: \.self) { Text($0.rawValue).tag($0) } }.pickerStyle(.menu) }
                Image(systemName: state.symbol).font(.system(size: 70, weight: .light)).foregroundStyle(state == .failed ? .orange : .indigo).padding(.top, 22)
                Text(state.title).font(.system(.largeTitle, design: .serif).bold())
                Text(state.detail).font(.title3).foregroundStyle(.secondary)
                if state == .processing { ProgressView().controlSize(.large) }
                Divider().padding(.vertical, 8)
                HStack {
                    Label("Create a new collection", systemImage: "square.stack.badge.plus")
                    Spacer()
                    if state != .active { Image(systemName: "lock.fill").foregroundStyle(.secondary) }
                }
                Button(state == .active ? "Open Plus feature" : "Preview active access") {
                    if state == .active { featureOpen = true } else { state = .active }
                }.buttonStyle(.borderedProminent)
                Button("Preview expired access") { state = .expired }.buttonStyle(.bordered)
                if featureOpen && state == .active { Label("The sample feature is available.", systemImage: "checkmark.circle").foregroundStyle(.green) }
            }.padding(28)
        }
        .navigationTitle("Purchase feedback").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { PurchaseStateGalleryDemo() } }
