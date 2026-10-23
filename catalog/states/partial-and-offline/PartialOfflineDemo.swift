import SwiftUI

struct PartialOfflineDemo: View {
    @State private var offline = true
    @State private var repaired = false
    @State private var task: Task<Void, Never>?
    @State private var status = "Saved yesterday at 4:30 PM"
    var body: some View {
        List {
            Section {
                HStack(spacing: 14) {
                    Image(systemName: offline ? "wifi.slash" : "wifi").font(.title2).foregroundStyle(offline ? .orange : .teal)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(offline ? "You’re offline" : "Back online").font(.headline)
                        Text(offline ? "Your saved places are still available." : "Unavailable details can now be retried.")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                }.padding(.vertical, 8)
                Label(status, systemImage: "clock").font(.caption).foregroundStyle(.secondary)
            }
            Section("Weekend places") {
                place("Harbor walk", detail: "2.4 km · Saved map", symbol: "water.waves")
                place("Forest trail", detail: "5.1 km · Saved map", symbol: "tree")
                VStack(alignment: .leading, spacing: 14) {
                    place("Mountain lookout", detail: repaired ? "7.2 km · Details updated" : "Details unavailable", symbol: "mountain.2")
                    if !repaired {
                        HStack {
                            if task != nil { ProgressView().controlSize(.small) }
                            else { Label("This item couldn’t be updated", systemImage: "exclamationmark.circle").font(.caption).foregroundStyle(.secondary) }
                            Spacer()
                            Button(task == nil ? "Retry" : "Retrying…") { retry() }.disabled(offline || task != nil)
                        }
                    }
                }.padding(.vertical, 6)
                place("Riverside picnic", detail: "1.8 km · Saved map", symbol: "basket")
            }
            Section("Connection preview") {
                Toggle("Offline", isOn: $offline)
                    .onChange(of: offline) { _, value in if value { cancel() } }
                Button("Reset unavailable details") { cancel(); repaired = false; status = "Saved yesterday at 4:30 PM" }
            }
        }
        .navigationTitle("Partial and offline").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    private func place(_ name: String, detail: String, symbol: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: symbol).font(.title2).foregroundStyle(.teal).frame(width: 36)
            VStack(alignment: .leading, spacing: 5) {
                Text(name).font(.headline)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
        }.padding(.vertical, 9)
    }
    private func retry() {
        guard !offline else { return }
        task?.cancel()
        task = Task {
            do { try await Task.sleep(for: .seconds(1)) } catch { return }
            repaired = true; status = "Mountain details just updated"; task = nil
        }
    }
    private func cancel() { task?.cancel(); task = nil }
}

#Preview { NavigationStack { PartialOfflineDemo() } }
