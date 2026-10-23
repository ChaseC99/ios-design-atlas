import SwiftUI
import AVKit

struct NativeVideoPlayerDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var player: AVPlayer?
    @State private var fixtureURL: URL?
    @State private var failure: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("A change of light").font(.system(.largeTitle, design: .serif))
            Group {
                if let player {
                    NativePlayer(player: player, fixtureURL: fixtureURL).aspectRatio(16.0 / 9.0, contentMode: .fit)
                        .clipShape(.rect(cornerRadius: 22)).accessibilityIdentifier("capture-ready")
                } else if let failure {
                    ContentUnavailableView("Video unavailable", systemImage: "video.slash", description: Text(failure))
                        .accessibilityIdentifier("capture-ready")
                } else { ProgressView("Preparing local movie").frame(maxWidth: .infinity, minHeight: 220) }
            }
            Text("A three-second color study").font(.title3)
            Text("Original artwork • Silent film").foregroundStyle(.secondary)
            if !capturing {
                Divider()
                Text("The native player supplies playback, scrubbing, and full-screen presentation. Picture in Picture depends on device and app configuration.")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
        }.padding(24).frame(maxWidth: 900).frame(maxWidth: .infinity)
        .navigationTitle("Screening room").navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                let url = try await makeMovie()
                guard !Task.isCancelled else { try? FileManager.default.removeItem(at: url); return }
                fixtureURL = url
                player = AVPlayer(url: url)
            } catch { if !Task.isCancelled { failure = "The local movie could not be generated." } }
        }
    }
    private struct NativePlayer: UIViewControllerRepresentable {
        let player: AVPlayer
        let fixtureURL: URL?
        func makeCoordinator() -> Coordinator { Coordinator(url: fixtureURL) }
        func makeUIViewController(context: Context) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            controller.player = player
            controller.allowsPictureInPicturePlayback = true
            return controller
        }
        func updateUIViewController(_ controller: AVPlayerViewController, context: Context) { controller.player = player }
        static func dismantleUIViewController(_ controller: AVPlayerViewController, coordinator: Coordinator) {
            controller.player?.pause()
            if let url = coordinator.url { try? FileManager.default.removeItem(at: url) }
        }
        final class Coordinator {
            let url: URL?
            init(url: URL?) { self.url = url }
        }
    }
    private func makeMovie() async throws -> URL {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("atlas-movie-\(UUID().uuidString).mov")
        let writer = try AVAssetWriter(outputURL: url, fileType: .mov)
        let input = AVAssetWriterInput(mediaType: .video, outputSettings: [AVVideoCodecKey: AVVideoCodecType.h264, AVVideoWidthKey: 320, AVVideoHeightKey: 180])
        let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input, sourcePixelBufferAttributes: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB, kCVPixelBufferWidthKey as String: 320, kCVPixelBufferHeightKey as String: 180])
        guard writer.canAdd(input) else { throw CocoaError(.fileWriteUnknown) }
        writer.add(input)
        guard writer.startWriting() else { throw writer.error ?? CocoaError(.fileWriteUnknown) }
        writer.startSession(atSourceTime: .zero)
        do {
            for frame in 0..<90 {
                try Task.checkCancellation()
                while !input.isReadyForMoreMediaData {
                    if writer.status == .failed { throw writer.error ?? CocoaError(.fileWriteUnknown) }
                    try await Task.sleep(for: .milliseconds(5))
                }
                var buffer: CVPixelBuffer?
                guard let pool = adaptor.pixelBufferPool, CVPixelBufferPoolCreatePixelBuffer(nil, pool, &buffer) == kCVReturnSuccess, let buffer else { throw CocoaError(.fileWriteUnknown) }
                CVPixelBufferLockBaseAddress(buffer, [])
                guard let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer), width: 320, height: 180, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
                    CVPixelBufferUnlockBaseAddress(buffer, []); throw CocoaError(.fileWriteUnknown)
                }
                context.setFillColor(UIColor(red: 0.05, green: 0.26, blue: 0.32, alpha: 1).cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 320, height: 180))
                context.setFillColor(UIColor.systemOrange.cgColor)
                context.fillEllipse(in: CGRect(x: 180 - Double(frame) * 0.8, y: 28 + sin(Double(frame) / 25) * 16, width: 72, height: 72))
                context.setFillColor(UIColor(red: 0.12, green: 0.46, blue: 0.48, alpha: 1).cgColor)
                context.fillEllipse(in: CGRect(x: -60, y: 120, width: 440, height: 130))
                CVPixelBufferUnlockBaseAddress(buffer, [])
                guard adaptor.append(buffer, withPresentationTime: CMTime(value: Int64(frame), timescale: 30)) else { throw writer.error ?? CocoaError(.fileWriteUnknown) }
            }
            input.markAsFinished()
            await writer.finishWriting()
            guard writer.status == .completed else { throw writer.error ?? CocoaError(.fileWriteUnknown) }
            return url
        } catch { writer.cancelWriting(); try? FileManager.default.removeItem(at: url); throw error }
    }
}
#Preview { NavigationStack { NativeVideoPlayerDemo() } }
