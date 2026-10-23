import SwiftUI
import AVFAudio

struct LocalAudioQueueDemo: View {
    @State private var player: AVAudioPlayer?
    @State private var index = 0
    @State private var expanded = false
    @State private var error: String?
    @State private var playing = false
    private let names = ["First light", "Open water", "Evening air"]
    private let frequencies = [220.0, 261.63, 329.63]
    var body: some View {
        List {
            Section {
                ForEach(names.indices, id: \.self) { item in
                    Button { select(item) } label: {
                        HStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 12).fill(item == index ? Color.teal.gradient : Color.indigo.gradient)
                                .frame(width: 54, height: 54).overlay(Image(systemName: "waveform").foregroundStyle(.white))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(names[item]).font(.headline).foregroundStyle(.primary)
                                Text("Original tone · 8 seconds").font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            if item == index { Image(systemName: playing ? "speaker.wave.2.fill" : "checkmark").foregroundStyle(.teal) }
                        }.padding(.vertical, 8)
                    }
                }
            } header: { Text("Quiet studies") }
            if let error { Section { Text(error).foregroundStyle(.secondary) } }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 16) {
                Button { expanded = true } label: {
                    HStack { Image(systemName: "waveform").font(.title2); Text(names[index]).font(.headline) }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.buttonStyle(.plain).accessibilityLabel("Expand player")
                Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.fill" : "play.fill") { toggle() }
                    .labelStyle(.iconOnly).font(.title2)
            }.padding(20).background(.regularMaterial, in: .rect(cornerRadius: 24)).padding(16)
        }
        .sheet(isPresented: $expanded) {
            VStack(spacing: 28) {
                Image(systemName: "waveform").font(.system(size: 80, weight: .ultraLight)).foregroundStyle(.teal).padding(.top, 30)
                Text(names[index]).font(.system(.largeTitle, design: .serif))
                TimelineView(.periodic(from: .now, by: 0.1)) { _ in
                    Slider(value: Binding(get: { player?.currentTime ?? 0 }, set: { player?.currentTime = $0 }), in: 0...8) { Text("Playback time") }
                    Text("\(Int(player?.currentTime ?? 0)) / 8 seconds").font(.caption.monospacedDigit()).foregroundStyle(.secondary)
                }
                HStack(spacing: 40) {
                    Button("Previous", systemImage: "backward.end.fill") { select((index + 2) % 3) }
                    Button(playing ? "Pause" : "Play", systemImage: playing ? "pause.circle.fill" : "play.circle.fill") { toggle() }.font(.system(size: 54))
                    Button("Next", systemImage: "forward.end.fill") { select((index + 1) % 3) }
                }.labelStyle(.iconOnly).font(.title2)
                Spacer()
            }.padding(28).presentationDetents([.medium, .large]).presentationDragIndicator(.visible)
        }
        .navigationTitle("Sound studies").navigationBarTitleDisplayMode(.inline)
        .task { prepare() }
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            if playing, let player, !player.isPlaying {
                if player.currentTime == 0 || player.currentTime >= player.duration - 0.2 { select((index + 1) % 3) }
                else { playing = false }
            }
        }
        .onDisappear { player?.stop(); playing = false; try? AVAudioSession.sharedInstance().setActive(false) }
        .accessibilityIdentifier("capture-ready")
    }
    private func select(_ next: Int) {
        let resume = playing
        player?.stop(); index = next; playing = false; prepare()
        if resume { toggle() }
    }
    private func prepare() {
        do { player = try AVAudioPlayer(data: Self.wav(frequency: frequencies[index])); player?.prepareToPlay() }
        catch { self.error = "The local audio could not be prepared." }
    }
    private func toggle() {
        if playing { player?.pause(); playing = false; return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            playing = player?.play() ?? false
            if !playing { error = "Audio playback is unavailable." }
        } catch { self.error = "Audio playback is unavailable." }
    }
    private static func wav(frequency: Double) -> Data {
        let rate = 22050, count = rate * 8
        var data = Data()
        func text(_ value: String) { data.append(contentsOf: value.utf8) }
        func uint16(_ value: UInt16) { var little = value.littleEndian; withUnsafeBytes(of: &little) { data.append(contentsOf: $0) } }
        func uint32(_ value: UInt32) { var little = value.littleEndian; withUnsafeBytes(of: &little) { data.append(contentsOf: $0) } }
        text("RIFF"); uint32(UInt32(36 + count * 2)); text("WAVEfmt "); uint32(16); uint16(1); uint16(1)
        uint32(UInt32(rate)); uint32(UInt32(rate * 2)); uint16(2); uint16(16); text("data"); uint32(UInt32(count * 2))
        for sample in 0..<count {
            let time = Double(sample) / Double(rate)
            let envelope = min(1, min(time * 5, (8 - time) * 5))
            let value = Int16(sin(time * frequency * 2 * .pi) * envelope * 2400)
            uint16(UInt16(bitPattern: value))
        }
        return data
    }
}
#Preview { NavigationStack { LocalAudioQueueDemo() } }
