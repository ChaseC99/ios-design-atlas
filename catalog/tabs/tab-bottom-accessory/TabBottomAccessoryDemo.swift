import SwiftUI

@available(iOS 26.0, *)
struct TabBottomAccessoryDemo: View {
    @State private var playing = false
    @State private var showPlayer = false
    var body: some View {
        TabView {
            Tab("Listen", systemImage: "headphones") {
                NavigationStack {
                    List {
                        Section {
                            ZStack {
                                LinearGradient(colors: [.indigo, .purple, .pink.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                Image(systemName: "waveform").font(.system(size: 95)).foregroundStyle(.white.opacity(0.85))
                            }.frame(height: 220).clipShape(.rect(cornerRadius: 20)).listRowInsets(EdgeInsets())
                        }
                        Section("A quieter rhythm") {
                            ForEach(1...20, id: \.self) { index in
                                HStack {
                                    Text(String(format: "%02d", index)).monospacedDigit().foregroundStyle(.secondary).frame(width: 30)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(["Blue hour", "Still water", "Somewhere familiar"][(index - 1) % 3])
                                        Text("Atlas Sessions").font(.caption).foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Button("Play track \(index)", systemImage: "play.fill") { playing = true }
                                        .labelStyle(.iconOnly).buttonStyle(.borderless)
                                }.padding(.vertical, 6)
                            }
                        }
                    }.navigationTitle("Listen")
                }
            }
            Tab("Library", systemImage: "music.note.list") { ContentUnavailableView("Your library", systemImage: "music.note.list") }
            Tab("Search", systemImage: "magnifyingglass", role: .search) { ContentUnavailableView("Find your sound", systemImage: "magnifyingglass") }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewBottomAccessory { AtlasMiniPlayer(playing: $playing, showPlayer: $showPlayer) }
        .sheet(isPresented: $showPlayer) {
            NavigationStack {
                VStack(spacing: 28) {
                    Image(systemName: "waveform").font(.system(size: 100)).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).frame(height: 280).background(.indigo.gradient, in: .rect(cornerRadius: 28))
                    Text("Blue hour").font(.largeTitle.bold())
                    Text("Atlas Sessions · Sample player").foregroundStyle(.secondary)
                    Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.fill" : "play.fill") { playing.toggle() }
                        .font(.largeTitle).labelStyle(.iconOnly)
                }.padding(28)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { showPlayer = false } } }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

@available(iOS 26.0, *)
private struct AtlasMiniPlayer: View {
    @Environment(\.tabViewBottomAccessoryPlacement) private var placement
    @Binding var playing: Bool
    @Binding var showPlayer: Bool
    var body: some View {
        HStack(spacing: 12) {
            Button { showPlayer = true } label: {
                HStack(spacing: 12) {
                    if placement != .inline {
                        Image(systemName: "waveform").foregroundStyle(.white)
                            .frame(width: 36, height: 36).background(.indigo.gradient, in: .rect(cornerRadius: 8))
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Blue hour").font(.subheadline.weight(.semibold))
                        if placement != .inline { Text("Atlas Sessions").font(.caption).foregroundStyle(.secondary) }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).contentShape(Rectangle())
            }.buttonStyle(.plain).accessibilityLabel("Open player: Blue hour")
            Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.fill" : "play.fill") { playing.toggle() }
                .labelStyle(.iconOnly).font(.title3).padding(.horizontal, 8)
        }.padding(.horizontal, 12).padding(.vertical, 6)
    }
}

@available(iOS 26.0, *)
#Preview { TabBottomAccessoryDemo() }
