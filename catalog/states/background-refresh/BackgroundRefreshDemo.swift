import SwiftUI

struct BackgroundRefreshDemo: View {
    @State private var refreshed = false
    @State private var task: Task<Void, Never>?
    @State private var status = "Saved yesterday"
    @State private var generation = 0
    private let places = ["Harbor walk", "Forest trail", "Mountain lookout", "Riverside picnic", "Garden café", "Ocean path", "Valley loop", "Lake shore", "Old town", "Hilltop view"]
    var body: some View {
        List {
            Section {
                HStack(spacing: 12) {
                    if task != nil { ProgressView().controlSize(.small) }
                    else { Image(systemName: refreshed ? "checkmark.circle" : "clock").foregroundStyle(.teal) }
                    Text(status).font(.subheadline)
                    Spacer()
                    if task != nil { Button("Cancel") { cancel() } }
                }.frame(minHeight: 32)
            }
            Section("Saved places") {
                ForEach(places, id: \.self) { name in
                    let index = places.firstIndex(of: name) ?? 0
                    HStack(spacing: 16) {
                        Image(systemName: "mappin.and.ellipse").font(.title2).foregroundStyle(.teal).frame(width: 36)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(name).font(.headline)
                            Text(refreshed ? "\(index + 2) notes · Updated just now" : "\(index + 1) notes · Saved yesterday")
                                .font(.subheadline).foregroundStyle(.secondary).lineLimit(1).minimumScaleFactor(0.8)
                        }
                    }.padding(.vertical, 12)
                }
            }
        }
        .refreshable { await refresh() }
        .toolbar {
            Button("Refresh", systemImage: "arrow.clockwise") { Task { await refresh() } }.disabled(task != nil)
        }
        .navigationTitle("Background refresh").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    private func refresh() async {
        guard task == nil else { return }
        generation += 1
        let current = generation
        status = "Updating saved places…"
        let operation = Task { @MainActor in
            do { try await Task.sleep(for: .seconds(2)) }
            catch {
                if current == generation { task = nil; status = "Refresh cancelled · Saved content kept" }
                return
            }
            guard current == generation else { return }
            refreshed = true; status = "Updated just now"; task = nil
        }
        task = operation
        await withTaskCancellationHandler {
            await operation.value
        } onCancel: {
            operation.cancel()
        }
    }
    private func cancel() {
        guard task != nil else { return }
        generation += 1
        task?.cancel(); task = nil; status = refreshed ? "Refresh cancelled · Updates kept" : "Refresh cancelled · Saved content kept"
    }
}

#Preview { NavigationStack { BackgroundRefreshDemo() } }
