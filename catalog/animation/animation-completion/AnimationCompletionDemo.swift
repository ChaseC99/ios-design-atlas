import SwiftUI

struct AnimationCompletionDemo: View {
    private enum Phase { case ready, working, success, failure }
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phase = Phase.ready
    @State private var fails = false
    @State private var previewReducedMotion = false
    @State private var message = "Ready to save your collection."
    @State private var generation = 0
    @State private var task: Task<Void, Never>?
    private var symbol: String {
        switch phase { case .ready: "square.and.arrow.down"; case .working: "arrow.triangle.2.circlepath"; case .success: "checkmark.circle.fill"; case .failure: "exclamationmark.triangle.fill" }
    }
    private var tint: Color {
        switch phase { case .failure: .orange; case .success: .green; default: .teal }
    }

    var body: some View {
        Form {
            Section {
                VStack(spacing: 24) {
                    ZStack {
                        Circle().fill(tint.opacity(0.12)).frame(width: 140, height: 140)
                        if phase == .working { ProgressView().controlSize(.large) }
                        else { Image(systemName: symbol).font(.system(size: 54)).foregroundStyle(tint).transition(.opacity) }
                    }
                    Text(message).font(.headline).multilineTextAlignment(.center)
                    Button(phase == .failure ? "Try again" : "Save collection", action: start)
                        .buttonStyle(.borderedProminent).disabled(phase == .working)
                }.frame(maxWidth: .infinity).padding(.vertical, 24)
            }
            Section {
                Toggle("Simulate an error", isOn: $fails)
                Toggle("Preview reduced motion", isOn: $previewReducedMotion)
                Button("Cancel and reset") {
                    generation += 1; task?.cancel(); phase = .ready
                    message = "Ready to save your collection."
                }
            }
        }
        .navigationTitle("Completion and result states")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { task?.cancel(); generation += 1 }
    }

    private func start() {
        generation += 1
        let token = generation
        let shouldFail = fails
        phase = .working
        message = "Saving your collection…"
        task = Task {
            do { try await Task.sleep(for: .seconds(1)) } catch { return }
            guard token == generation, !Task.isCancelled else { return }
            withAnimation(reduceMotion || previewReducedMotion ? nil : .smooth(duration: 0.4), completionCriteria: .logicallyComplete) {
                phase = shouldFail ? .failure : .success
            } completion: {
                guard token == generation else { return }
                message = shouldFail ? "Couldn’t save. Try again." : "Collection saved."
            }
        }
    }
}

#Preview { NavigationStack { AnimationCompletionDemo() } }
