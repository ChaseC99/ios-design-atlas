import SwiftUI

struct OptimisticUpdatesDemo: View {
    @State private var favorite = false
    @State private var confirmed = false
    @State private var shouldFail = true
    @State private var task: Task<Void, Never>?
    @State private var status = "Ready"
    @State private var failed = false
    var body: some View {
        Form {
            Section {
                VStack(spacing: 20) {
                    Image(systemName: "sun.horizon.fill").font(.system(size: 68)).foregroundStyle(.orange)
                    Text("Harbor at golden hour").font(.title2.bold()).multilineTextAlignment(.center)
                    Text("A place worth returning to.").foregroundStyle(.secondary)
                    Button {
                        update(to: !favorite)
                    } label: {
                        Label(favorite ? "In your favorites" : "Add to favorites", systemImage: favorite ? "heart.fill" : "heart")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent).tint(favorite ? .pink : .teal).disabled(task != nil)
                }.padding(.vertical, 24)
                HStack(spacing: 12) {
                    if task != nil { ProgressView().controlSize(.small) }
                    else { Image(systemName: failed ? "exclamationmark.circle" : "checkmark.circle").foregroundStyle(failed ? .orange : .teal) }
                    Text(status).font(.subheadline)
                }
                if failed { Button("Retry change") { update(to: !confirmed) } }
                if task != nil { Button("Cancel and undo") { cancel() } }
            }
            Section("Local response") {
                Toggle("Simulate failure", isOn: $shouldFail).disabled(task != nil)
                LabeledContent("Confirmed value", value: confirmed ? "Favorite" : "Not favorite")
                LabeledContent("Visible value", value: favorite ? "Favorite" : "Not favorite")
            }
        }
        .navigationTitle("Optimistic updates").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    private func update(to value: Bool) {
        guard task == nil else { return }
        favorite = value; failed = false; status = "Saving change…"
        let fails = shouldFail
        task = Task {
            do { try await Task.sleep(for: .milliseconds(1600)) } catch { return }
            if fails {
                favorite = confirmed; failed = true; status = "Couldn’t save · Previous value restored"
            } else {
                confirmed = favorite; status = "Change saved"
            }
            task = nil
        }
    }
    private func cancel() {
        guard task != nil else { return }
        task?.cancel(); task = nil; favorite = confirmed; failed = false; status = "Cancelled · Previous value restored"
    }
}

#Preview { NavigationStack { OptimisticUpdatesDemo() } }
