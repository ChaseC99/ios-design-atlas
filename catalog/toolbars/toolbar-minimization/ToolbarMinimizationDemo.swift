import SwiftUI

@available(iOS 27.0, *)
struct ToolbarMinimizationDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var enabled = true
    @State private var edgeRestoration = false
    @State private var adjustSafeArea = true
    @State private var saved = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("A longer\nway home.").font(.system(size: 44, weight: .medium, design: .serif))
                Text("FIELD JOURNAL · ISSUE 06").font(.caption).tracking(2).foregroundStyle(.secondary)
                if !capturing {
                    Toggle("Minimize on scroll down", isOn: $enabled)
                    Toggle("Restore at scroll edge", isOn: $edgeRestoration)
                    Toggle("Adjust safe area", isOn: $adjustSafeArea)
                }
                ForEach(0..<12) { index in
                    VStack(alignment: .leading, spacing: 18) {
                        if index % 3 == 0 {
                            RoundedRectangle(cornerRadius: 28).fill([Color.orange, .teal, .indigo][index / 3 % 3].gradient)
                                .frame(height: 240).overlay(Image(systemName: "leaf").font(.system(size: 72, weight: .ultraLight)).foregroundStyle(.white))
                        }
                        Text("\(index + 1). A small detour").font(.title2.weight(.medium))
                        Text("Turn down the unfamiliar street. Notice the old trees and the changing light. Some of the best things happen when there is a little room left in the day.")
                            .font(.body).lineSpacing(6).foregroundStyle(.secondary)
                    }
                }
            }.padding(28)
        }
        .navigationTitle("Field journal").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(saved ? "Unsave" : "Save", systemImage: saved ? "bookmark.fill" : "bookmark") { saved.toggle() }
            }
            ToolbarItem(placement: .bottomBar) { Text("Issue 06 · 8 min read").font(.subheadline) }
        }
        .toolbarMinimizationBehavior(enabled ? .onScrollDown : .never, for: .navigationBar, .bottomBar)
        .toolbarMinimizationRestoration(edgeRestoration ? .atScrollEdge : .automatic, for: .navigationBar, .bottomBar)
        .toolbarMinimizationSafeAreaAdjustment(adjustSafeArea ? .enabled : .disabled, for: .navigationBar, .bottomBar)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.0, *) { NavigationStack { ToolbarMinimizationDemo() } } }
