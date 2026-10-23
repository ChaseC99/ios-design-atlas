import SwiftUI

struct RefreshPaginationDemo: View {
    @State private var items = Array(1...12)
    @State private var generation = 0
    @State private var loading = false
    private let limit = 36
    var body: some View {
        List {
            Section {
                ForEach(items, id: \.self) { number in
                    HStack(spacing: 18) {
                        RoundedRectangle(cornerRadius: 14).fill([Color.teal, .orange, .indigo][number % 3].gradient)
                            .frame(width: 64, height: 64)
                            .overlay(Image(systemName: "leaf").foregroundStyle(.white).font(.title2))
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Field study \(number)").font(.headline)
                            Text(generation == 0 ? "Collected inspiration" : "Refreshed collection \(generation)").font(.subheadline).foregroundStyle(.secondary)
                        }
                    }.padding(.vertical, 8)
                }
            }
            Section {
                if items.count < limit {
                    HStack { Spacer(); ProgressView("Loading more"); Spacer() }
                        .padding(.vertical, 12).task(id: items.count) { await loadNextPage() }
                } else {
                    Text("You’re all caught up.").foregroundStyle(.secondary).frame(maxWidth: .infinity).padding()
                }
            }
        }
        .refreshable {
            do { try await Task.sleep(for: .milliseconds(650)) } catch { return }
            generation += 1; items = Array(1...12)
        }
        .navigationTitle("Latest studies")
        .accessibilityIdentifier("capture-ready")
    }
    @MainActor private func loadNextPage() async {
        guard !loading, items.count < limit else { return }
        loading = true
        defer { loading = false }
        let oldCount = items.count
        let oldGeneration = generation
        do { try await Task.sleep(for: .milliseconds(650)) } catch { return }
        guard items.count == oldCount, generation == oldGeneration else { return }
        items.append(contentsOf: (oldCount + 1)...min(oldCount + 12, limit))
    }
}
#Preview { NavigationStack { RefreshPaginationDemo() } }
