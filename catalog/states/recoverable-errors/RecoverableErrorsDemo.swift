import SwiftUI

struct RecoverableErrorsDemo: View {
    private enum Phase { case failed, loading, loaded, cancelled }
    @State private var phase = Phase.failed
    @State private var shouldFail = false
    @State private var attempts = 0
    @State private var task: Task<Void, Never>?
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch phase {
                case .failed, .cancelled:
                    ContentUnavailableView {
                        Label(phase == .cancelled ? "Loading cancelled" : "Couldn’t load collection", systemImage: phase == .cancelled ? "pause.circle" : "exclamationmark.icloud")
                    } description: {
                        Text(phase == .cancelled ? "Your saved places are unchanged." : "The sample request failed. You can try again.")
                    } actions: {
                        Button("Retry", systemImage: "arrow.clockwise") { retry() }.buttonStyle(.borderedProminent)
                    }
                case .loading:
                    VStack(spacing: 24) {
                        ProgressView("Loading collection…")
                        Button("Cancel", role: .cancel) { cancel() }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                case .loaded:
                    List {
                        Section {
                            Label("Collection ready", systemImage: "checkmark.circle.fill").foregroundStyle(.green)
                        }
                        Section("Weekend places") {
                            Label("Harbor walk", systemImage: "water.waves")
                            Label("Forest trail", systemImage: "tree")
                            Label("Mountain lookout", systemImage: "mountain.2")
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            Form {
                Toggle("Next attempt fails", isOn: $shouldFail).disabled(phase == .loading)
                LabeledContent("Attempts", value: "\(attempts)")
                Button("Reset to error") { cancel(); attempts = 0; phase = .failed }.disabled(phase == .loading)
            }.frame(height: 220)
        }
        .navigationTitle("Errors and retry").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    private func retry() {
        task?.cancel(); attempts += 1; phase = .loading
        let fails = shouldFail
        task = Task {
            do { try await Task.sleep(for: .milliseconds(1400)) } catch { return }
            phase = fails ? .failed : .loaded
            task = nil
        }
    }
    private func cancel() {
        guard task != nil else { return }
        task?.cancel(); task = nil; phase = .cancelled
    }
}

#Preview { NavigationStack { RecoverableErrorsDemo() } }
