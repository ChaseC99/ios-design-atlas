import SwiftUI
import PhotosUI

struct SystemPhotoSelectionDemo: View {
    @State private var single: PhotosPickerItem?
    @State private var multiple: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    @State private var loading = false
    @State private var loadID = UUID()
    @State private var message = "Choose images to start a collection."
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A few favorites.").font(.system(.largeTitle, design: .serif))
                if images.isEmpty {
                    RoundedRectangle(cornerRadius: 28).fill(.teal.gradient).aspectRatio(1.2, contentMode: .fit)
                        .overlay(Image(systemName: "photo.stack").font(.system(size: 70, weight: .ultraLight)).foregroundStyle(.white))
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))]) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(uiImage: images[index]).resizable().scaledToFill()
                                .frame(height: 180).frame(maxWidth: .infinity).clipped().clipShape(.rect(cornerRadius: 18))
                        }
                    }
                }
                HStack {
                    PhotosPicker(selection: $single, matching: .images) { Label("Choose one", systemImage: "photo") }
                    Spacer()
                    PhotosPicker(selection: $multiple, maxSelectionCount: 6, selectionBehavior: .ordered, matching: .images) {
                        Label("Choose several", systemImage: "photo.on.rectangle.angled")
                    }
                }.buttonStyle(.bordered)
                if loading { ProgressView("Loading selected images") }
                Text(message).font(.subheadline).foregroundStyle(.secondary)
            }.padding(24).frame(maxWidth: 760).frame(maxWidth: .infinity)
        }
        .navigationTitle("Photo collection").navigationBarTitleDisplayMode(.inline)
        .task(id: single) { if let single { await load([single]) } }
        .task(id: multiple) { if !multiple.isEmpty { await load(multiple) } }
        .accessibilityIdentifier("capture-ready")
    }
    private func load(_ items: [PhotosPickerItem]) async {
        let token = UUID()
        loadID = token
        loading = true
        defer { if loadID == token { loading = false } }
        var result: [UIImage] = []
        for item in items {
            do {
                if let data = try await item.loadTransferable(type: Data.self), let image = UIImage(data: data) { result.append(image) }
            } catch { }
            guard !Task.isCancelled && loadID == token else { return }
        }
        images = result
        message = result.count == items.count ? "\(result.count) images selected." : "Some images could not be loaded. They may need a network connection; choose them again to retry."
    }
}
#Preview { NavigationStack { SystemPhotoSelectionDemo() } }
