import SwiftUI

struct ImageFittingAvatarsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var imageAvailable = true
    @State private var alignment = 1
    private var cropAlignment: Alignment { alignment == 0 ? .leading : alignment == 2 ? .trailing : .center }
    private var artwork: Image {
        let renderer = ImageRenderer(content: OriginalLandscapeArtwork().frame(width: 600, height: 320))
        renderer.scale = 1
        return Image(uiImage: renderer.uiImage ?? UIImage())
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("FIT").font(.caption2).tracking(2).foregroundStyle(.secondary)
                artwork.resizable().scaledToFit().frame(maxWidth: .infinity).frame(height: 180)
                    .background(Color(uiColor: .secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 24))
                Text("FILL").font(.caption2).tracking(2).foregroundStyle(.secondary)
                GeometryReader { geometry in
                    artwork.resizable().scaledToFill()
                        .frame(width: geometry.size.width, height: 220, alignment: cropAlignment)
                        .clipped()
                }
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                HStack(spacing: 24) {
                    Group {
                        if imageAvailable { artwork.resizable().scaledToFill() }
                        else { Text("AL").font(.title2.weight(.semibold)).frame(maxWidth: .infinity, maxHeight: .infinity).background(.teal.opacity(0.15)) }
                    }.frame(width: 76, height: 76).clipShape(Circle()).accessibilityLabel("Alex Lee")
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Alex Lee").font(.headline)
                        Text(imageAvailable ? "Original vector artwork" : "Initials fallback").font(.subheadline).foregroundStyle(.secondary)
                    }
                }
                if !capturing {
                    Toggle("Avatar image available", isOn: $imageAvailable)
                    Picker("Crop alignment", selection: $alignment) {
                        Text("Leading").tag(0); Text("Center").tag(1); Text("Trailing").tag(2)
                    }.pickerStyle(.segmented)
                }
            }.padding(24).frame(maxWidth: 640)
        }
        .navigationTitle("A frame for an image").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct OriginalLandscapeArtwork: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .teal], startPoint: .top, endPoint: .bottom)
            Circle().fill(.orange).frame(width: 150).offset(x: 140, y: -50)
            Ellipse().fill(Color(red: 0.04, green: 0.28, blue: 0.31)).frame(width: 760, height: 220).offset(x: -100, y: 150)
            Ellipse().fill(Color(red: 0.08, green: 0.42, blue: 0.40)).frame(width: 700, height: 160).offset(x: 180, y: 160)
        }.clipped()
    }
}
#Preview { NavigationStack { ImageFittingAvatarsDemo() } }
