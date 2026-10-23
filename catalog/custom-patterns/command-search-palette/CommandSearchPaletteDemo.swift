import SwiftUI

struct CommandSearchPaletteDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var showing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var query = ""
    @State private var favoritesOnly = false
    @State private var notes = [Note(id: 0, title: "A slower morning", favorite: true), Note(id: 1, title: "Reading room ideas", favorite: false), Note(id: 2, title: "The coastal trail", favorite: true)]
    @FocusState private var focused: Bool
    private let commands = [Command(id: 0, title: "Create a note", symbol: "square.and.pencil", detail: "Add to your workspace"), Command(id: 1, title: "Toggle favorites", symbol: "star", detail: "Change the visible collection"), Command(id: 2, title: "Sort alphabetically", symbol: "arrow.up.arrow.down", detail: "Arrange notes by title")]
    private var matches: [Command] { commands.filter { query.isEmpty || $0.title.localizedCaseInsensitiveContains(query) } }
    var body: some View {
        ZStack(alignment: .top) {
            List(notes.filter { !favoritesOnly || $0.favorite }) { note in
                HStack { Text(note.title).padding(.vertical, 16); Spacer(); if note.favorite { Image(systemName: "star.fill").foregroundStyle(.orange) } }
            }
            .allowsHitTesting(!showing).accessibilityHidden(showing)
            if showing {
                Color.black.opacity(0.12).ignoresSafeArea().onTapGesture { dismiss() }.accessibilityHidden(true)
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                        TextField("Search actions", text: $query).focused($focused).submitLabel(.go)
                            .onSubmit { if let first = matches.first { perform(first.id) } }
                        Button("Close search", systemImage: "xmark.circle.fill") { dismiss() }
                            .labelStyle(.iconOnly).foregroundStyle(.secondary).keyboardShortcut(.escape, modifiers: [])
                    }.padding(20)
                    Divider()
                    if matches.isEmpty { ContentUnavailableView.search(text: query).frame(height: 200) }
                    else {
                        VStack(spacing: 2) {
                            ForEach(matches) { command in
                                Button { perform(command.id) } label: {
                                    HStack(spacing: 16) {
                                        Image(systemName: command.symbol).font(.title2).foregroundStyle(.teal).frame(width: 30)
                                        VStack(alignment: .leading, spacing: 5) { Text(command.title).font(.headline); Text(command.detail).font(.caption).foregroundStyle(.secondary) }
                                        Spacer()
                                        Image(systemName: "return").font(.caption).foregroundStyle(.tertiary)
                                    }.padding(18).contentShape(Rectangle())
                                }.buttonStyle(.plain)
                            }
                        }.padding(8)
                    }
                }
                .background(.regularMaterial, in: .rect(cornerRadius: 26))
                .shadow(color: .black.opacity(0.1), radius: 28, y: 12)
                .accessibilityAddTraits(.isModal)
                .padding(24).frame(maxWidth: 650)
            }
        }
        .navigationTitle(favoritesOnly ? "Favorites" : "Workspace").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Search commands", systemImage: "command") { showing = true; if !capturing { focused = true } }
                    .keyboardShortcut("k", modifiers: .command)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
    private func dismiss() { showing = false; focused = false; query = "" }
    private func perform(_ command: Int) {
        switch command {
        case 0: favoritesOnly = false; notes.insert(Note(id: (notes.map(\.id).max() ?? 0) + 1, title: "Untitled note", favorite: false), at: 0)
        case 1: favoritesOnly.toggle()
        default: notes.sort { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
        }
        dismiss()
    }
    private struct Note: Identifiable { let id: Int; let title: String; let favorite: Bool }
    private struct Command: Identifiable { let id: Int; let title: String; let symbol: String; let detail: String }
}
#Preview { NavigationStack { CommandSearchPaletteDemo() } }
