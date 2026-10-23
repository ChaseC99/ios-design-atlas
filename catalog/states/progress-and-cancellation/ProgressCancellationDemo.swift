import SwiftUI

struct ProgressCancellationDemo: View {
    @State private var progress = 0.42
    @State private var task: Task<Void, Never>?
    @State private var style = "Determinate"
    @State private var placement = "Inline"
    @State private var status = "Paused"
    var body: some View {
        VStack(spacing: 0) {
            if placement == "Full screen" {
                VStack(spacing: 28) {
                    Image(systemName: "square.stack.3d.up.fill").font(.system(size: 64)).foregroundStyle(.teal)
                    Text("Preparing your collection").font(.title2.bold()).multilineTextAlignment(.center)
                    indicator
                    Text(status).foregroundStyle(.secondary)
                }.padding(32).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Form {
                if placement == "Inline" {
                    Section {
                        HStack(spacing: 18) {
                            Image(systemName: "square.stack.3d.up.fill").font(.largeTitle).foregroundStyle(.teal)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Weekend collection").font(.headline)
                                Text("24 photographs").foregroundStyle(.secondary)
                            }
                        }.padding(.vertical, 12)
                        indicator
                        LabeledContent("Status", value: status)
                    }
                }
                Section {
                    HStack {
                        Button(progress == 1 ? "Start again" : "Continue") { start() }.disabled(task != nil)
                        Spacer()
                        Button("Cancel", role: .cancel) { cancel() }.disabled(task == nil)
                    }.buttonStyle(.borderless)
                }
                Section("Presentation") {
                    Picker("Progress", selection: $style) {
                        Text("Determinate").tag("Determinate")
                        Text("Indeterminate").tag("Indeterminate")
                    }
                    Picker("Placement", selection: $placement) {
                        Text("Inline").tag("Inline")
                        Text("Full screen").tag("Full screen")
                    }
                }
            }
            .frame(maxHeight: placement == "Full screen" ? 270 : .infinity)
        }
        .navigationTitle("Progress and cancellation").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    @ViewBuilder private var indicator: some View {
        if style == "Determinate" {
            ProgressView(value: progress) { Text("Preparing photographs") } currentValueLabel: { Text(progress.formatted(.percent.precision(.fractionLength(0)))) }
                .tint(.teal)
        } else { ProgressView(task == nil ? "Ready to continue" : "Preparing photographs…").frame(maxWidth: .infinity) }
    }
    private func start() {
        task?.cancel()
        if progress >= 1 { progress = 0 }
        status = "Preparing…"
        task = Task {
            while progress < 1 {
                do { try await Task.sleep(for: .milliseconds(180)) } catch { return }
                progress = min(1, progress + 0.04)
            }
            status = "Collection ready"
            task = nil
        }
    }
    private func cancel() {
        guard task != nil else { return }
        task?.cancel(); task = nil; status = "Cancelled · progress kept"
    }
}

#Preview { NavigationStack { ProgressCancellationDemo() } }
