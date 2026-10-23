import SwiftUI

struct ImportProgressFlowDemo: View {
    @State private var processed = 0
    @State private var running = false
    @State private var started = false
    private let titles = ["Quiet mornings", "Open water", "The coastal path", "Small adventures", "A slower weekend", "Something worth keeping"]
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var complete: Bool { processed == titles.count }
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text(complete ? "Ready for another day." : "Keep your good things together.").font(.system(.largeTitle, design: .serif).bold())
                Text(complete ? "All sample notes are ready." : running ? "Processing sample notes…" : started ? "Import paused" : "A sample import of six local notes.").foregroundStyle(.secondary)
                ProgressView(value: Double(processed), total: Double(titles.count)).tint(.indigo)
                Text("\(processed) of \(titles.count) notes").font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            }.padding(26)
            List(titles.indices, id: \.self) { index in
                Label(titles[index], systemImage: index < processed ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(index < processed ? .primary : .secondary).padding(.vertical, 7)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Cancel", role: .cancel) { running = false; processed = 0; started = false }.disabled(!started)
                Spacer()
                Button(complete ? "Import again" : running ? "Pause" : started ? "Resume" : "Begin import") {
                    if complete { processed = 0 }
                    started = true; running.toggle()
                }.buttonStyle(.borderedProminent)
            }.padding().background(.bar)
        }
        .task(id: running) {
            guard running else { return }
            while processed < titles.count {
                do { try await Task.sleep(for: .milliseconds(200)) } catch { return }
                guard !Task.isCancelled else { return }
                processed += 1
                if isCapturing && processed == 3 { running = false; return }
            }
            running = false
        }
        .onAppear { if isCapturing { started = true; running = true } }
        .navigationTitle("Sample import").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ImportProgressFlowDemo() } }
