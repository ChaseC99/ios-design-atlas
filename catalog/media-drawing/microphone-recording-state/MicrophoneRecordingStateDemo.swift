import SwiftUI
import AVFAudio

struct MicrophoneRecordingStateDemo: View {
    @State private var recorder: AVAudioRecorder?
    @State private var recording = false
    @State private var requesting = false
    @State private var visible = true
    @State private var elapsed = 0.0
    @State private var levels: [CGFloat] = []
    @State private var status = "Ready when you are"
    @State private var recordingURL: URL?
    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            Text("A thought, captured.").font(.system(.largeTitle, design: .serif))
            Canvas { context, size in
                let values = levels.isEmpty ? Array(repeating: CGFloat(0.02), count: 40) : levels
                for (index, level) in values.enumerated() {
                    let height = max(2, level * size.height)
                    let x = CGFloat(index) * size.width / 40
                    context.fill(Path(roundedRect: CGRect(x: x, y: (size.height - height) / 2, width: 4, height: height), cornerRadius: 2), with: .color(recording ? .red : .secondary.opacity(0.35)))
                }
            }.frame(height: 150).accessibilityLabel(recording ? "Live microphone level" : "Microphone idle")
            Text(elapsed, format: .number.precision(.fractionLength(1))).font(.system(size: 52, weight: .light, design: .rounded)).monospacedDigit()
            Text(status).font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
            Button {
                if recording { stop() } else { Task { await start() } }
            } label: {
                Image(systemName: recording ? "stop.fill" : "mic.fill").font(.title)
                    .frame(width: 76, height: 76).foregroundStyle(.white).background(.red, in: Circle())
            }.accessibilityLabel(recording ? "Stop recording" : "Start recording").disabled(requesting)
            Spacer()
            Text("Recordings stay in this session and are removed when you leave.").font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }.padding(28).frame(maxWidth: 650).frame(maxWidth: .infinity)
        .navigationTitle("Voice note").navigationBarTitleDisplayMode(.inline)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            guard recording, let recorder else { return }
            recorder.updateMeters(); elapsed = recorder.currentTime
            levels.append(CGFloat(pow(10, recorder.averagePower(forChannel: 0) / 30)))
            if levels.count > 40 { levels.removeFirst(levels.count - 40) }
        }
        .onAppear { visible = true }
        .onDisappear { visible = false; stop(); if let recordingURL { try? FileManager.default.removeItem(at: recordingURL) } }
        .accessibilityIdentifier("capture-ready")
    }
    private func start() async {
        guard Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") is String else {
            status = "Microphone access is not configured in this app build."; return
        }
        requesting = true
        defer { requesting = false }
        let authorized = await AVAudioApplication.requestRecordPermission()
        guard visible && !Task.isCancelled else { return }
        guard authorized else { status = "Microphone access is unavailable. You can review access in Settings."; return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            if let recordingURL { try? FileManager.default.removeItem(at: recordingURL) }
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("atlas-voice-\(UUID().uuidString).m4a")
            recordingURL = url
            let recorder = try AVAudioRecorder(url: url, settings: [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100, AVNumberOfChannelsKey: 1])
            recorder.isMeteringEnabled = true
            self.recorder = recorder
            recording = recorder.record()
            elapsed = 0; levels = []; status = recording ? "Recording" : "Audio input is unavailable."
        } catch { status = "Recording could not start with the current audio input." }
    }
    private func stop() {
        recorder?.stop()
        if recording { status = "Recording stopped" }
        recording = false
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}
#Preview { NavigationStack { MicrophoneRecordingStateDemo() } }
