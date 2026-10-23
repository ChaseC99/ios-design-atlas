import SwiftUI

struct NavigationScrollRestorationDemo: View {
    @State private var position: Int? = 8
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(1...40, id: \.self) { index in
                        NavigationLink(value: index) {
                            HStack(spacing: 18) {
                                Text(String(format: "%02d", index)).font(.system(.title2, design: .rounded).weight(.semibold)).foregroundStyle(.indigo)
                                    .frame(width: 48, height: 60).background(.indigo.opacity(0.08), in: .rect(cornerRadius: 12))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(["Quiet corners", "Open water", "The slower route", "Something worth keeping"][(index - 1) % 4]).font(.headline)
                                    Text("Field note \(index)").font(.subheadline).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").font(.caption.weight(.semibold)).foregroundStyle(.tertiary)
                            }.padding(16).background(.background, in: .rect(cornerRadius: 20))
                        }.buttonStyle(.plain).id(index)
                    }
                }.scrollTargetLayout().padding(20)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .scrollPosition(id: $position)
            .navigationTitle("Field notes")
            .navigationDestination(for: Int.self) { index in
                VStack(spacing: 20) {
                    Image(systemName: "book.pages").font(.system(size: 72)).foregroundStyle(.indigo)
                    Text("Field note \(index)").font(.largeTitle.bold())
                    Text("Return to find your place in the collection.").foregroundStyle(.secondary)
                }.padding().navigationTitle("Note \(index)").navigationBarTitleDisplayMode(.inline)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationScrollRestorationDemo() }
