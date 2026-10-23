import SwiftUI

struct GeometryAspectDemo: View {
    @State private var ratio = "16:9"
    private var aspect: CGFloat {
        switch ratio { case "4:3": 4.0 / 3.0; case "Square": 1; default: 16.0 / 9.0 }
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Picker("Aspect ratio", selection: $ratio) {
                    ForEach(["16:9", "4:3", "Square"], id: \.self) { Text($0) }
                }.pickerStyle(.segmented)
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 24).fill(.teal.gradient)
                        .overlay {
                            Image(systemName: "mountain.2.fill").font(.system(size: 64)).foregroundStyle(.white)
                        }
                        .overlay(alignment: .bottomTrailing) {
                            Text("\(Int(geometry.size.width)) × \(Int(geometry.size.height)) pt")
                                .font(.caption.monospaced()).padding(12).foregroundStyle(.white)
                        }
                }.aspectRatio(aspect, contentMode: .fit)
                Text("Sized to the container").font(.title2.bold())
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(["Coast", "Forest", "Mountains", "City"], id: \.self) { place in
                            Text(place).font(.headline).frame(height: 120)
                                .containerRelativeFrame(.horizontal, count: 2, spacing: 12)
                                .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
                        }
                    }.scrollTargetLayout()
                }.scrollTargetBehavior(.viewAligned)
            }.padding(24).frame(maxWidth: 680).frame(maxWidth: .infinity)
        }
        .navigationTitle("Geometry and aspect ratios")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { GeometryAspectDemo() } }
