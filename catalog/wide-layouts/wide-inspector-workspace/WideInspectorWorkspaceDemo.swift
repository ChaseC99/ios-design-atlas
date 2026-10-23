import SwiftUI

struct WideInspectorWorkspaceDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var compactColumn: NavigationSplitViewColumn = .detail
    @State private var notebook: String? = "Journal"
    @State private var selection: String? = "A slower morning"
    @State private var inspector = false
    @State private var favorite = true
    @State private var lineSpacing = 8.0
    @State private var drafts = [
        "A slower morning": "Leave a little room in the day.\n\nWalk without a destination. Notice the light on the water. Find a quiet place to write down one thing worth remembering.",
        "Along the coast": "The path follows the headland, past the cypress trees and down to the small cove.",
        "Gathering ideas": "A reading room with a long table.\nA window facing the trees.\nA shelf for things in progress.",
        "Weekend plans": "Bring a notebook. Take the early train. Leave the afternoon open."
    ]
    private var titles: [String] { notebook == "Ideas" ? ["Gathering ideas", "Weekend plans"] : ["A slower morning", "Along the coast"] }
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility, preferredCompactColumn: $compactColumn) {
            List(selection: $notebook) {
                Label("Journal", systemImage: "book.closed").tag("Journal")
                Label("Ideas", systemImage: "lightbulb").tag("Ideas")
            }
            .navigationTitle("Notebooks")
            .navigationSplitViewColumnWidth(min: 180, ideal: 220, max: 280)
            .onChange(of: notebook) { _, _ in selection = titles.first }
        } content: {
            List(titles, id: \.self, selection: $selection) { title in
                VStack(alignment: .leading, spacing: 7) {
                    Text(title).font(.headline)
                    Text(drafts[title] ?? "").font(.subheadline).foregroundStyle(.secondary).lineLimit(2)
                }.padding(.vertical, 8).tag(title)
            }
            .navigationTitle(notebook ?? "Notes")
            .navigationSplitViewColumnWidth(min: 220, ideal: 280, max: 360)
        } detail: {
            if let selection {
                VStack(alignment: .leading, spacing: 16) {
                    Label("PERSONAL JOURNAL", systemImage: "sun.max").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                    Text(selection).font(.system(.largeTitle, design: .serif))
                    TextEditor(text: Binding(get: { drafts[selection] ?? "" }, set: { drafts[selection] = $0 }))
                        .font(.body).lineSpacing(lineSpacing).scrollContentBackground(.hidden)
                        .accessibilityLabel("Document text")
                }
                .padding(24).frame(maxWidth: 700).frame(maxWidth: .infinity, alignment: .top)
                .navigationTitle("Journal").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Document inspector", systemImage: "sidebar.right") { inspector.toggle() }
                    }
                }
                .inspector(isPresented: $inspector) {
                    Form {
                        Section("Document") {
                            LabeledContent("Notebook", value: notebook ?? "Journal")
                            Toggle("Favorite", isOn: $favorite)
                        }
                        Section("Reading") {
                            Slider(value: $lineSpacing, in: 0...18) { Text("Line spacing") }
                            LabeledContent("Line spacing", value: "\(Int(lineSpacing)) pt")
                        }
                    }.inspectorColumnWidth(min: 240, ideal: 280, max: 340)
                }
            } else {
                ContentUnavailableView("Choose a note", systemImage: "doc.text")
            }
        }
        .task { if capturing && sizeClass == .regular { inspector = true } }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { WideInspectorWorkspaceDemo() }
