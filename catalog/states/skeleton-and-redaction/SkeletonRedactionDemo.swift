import SwiftUI

struct SkeletonRedactionDemo: View {
    @State private var loaded = false
    @State private var task: Task<Void, Never>?
    @State private var status = "Collection preview"
    @State private var saved = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 20) {
                    RoundedRectangle(cornerRadius: 24).fill(.teal.opacity(0.12))
                        .frame(height: 220)
                        .overlay { Image(systemName: "mountain.2.fill").font(.system(size: 70)).foregroundStyle(.teal) }
                    Text("A weekend in the mountains").font(.largeTitle.bold())
                    Text("Three trails, a small cabin, and a slower pace. A collection for taking the long way home.")
                        .foregroundStyle(.secondary)
                    HStack {
                        Label("12 places", systemImage: "mappin.and.ellipse")
                        Spacer()
                        Label("4 days", systemImage: "calendar")
                    }.font(.subheadline).foregroundStyle(.secondary)
                }
                .redacted(reason: loaded ? [] : .placeholder)
                .accessibilityHidden(!loaded)
                Button(saved ? "Saved to collections" : "Save collection", systemImage: saved ? "checkmark" : "bookmark") { saved.toggle() }
                    .buttonStyle(.borderedProminent).disabled(!loaded)
                HStack {
                    if task != nil { ProgressView().controlSize(.small) }
                    Text(status).font(.subheadline).foregroundStyle(.secondary)
                }.frame(height: 24)
                Divider()
                HStack {
                    Button(loaded ? "Reload sample" : "Load sample") { load() }.disabled(task != nil)
                    Spacer()
                    Button("Cancel") { cancel() }.disabled(task == nil)
                }
                Button("Reset to placeholder") { cancel(); loaded = false; saved = false; status = "Collection preview" }
            }.padding(24)
        }
        .navigationTitle("Skeletons and redaction").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { cancel() }
    }
    private func load() {
        task?.cancel(); loaded = false; saved = false; status = "Loading collection…"
        task = Task {
            do { try await Task.sleep(for: .seconds(2)) } catch { return }
            loaded = true; status = "Collection ready"; task = nil
        }
    }
    private func cancel() {
        guard task != nil else { return }
        task?.cancel(); task = nil; status = "Loading cancelled"
    }
}

#Preview { NavigationStack { SkeletonRedactionDemo() } }
