import SwiftUI
import UIKit

struct SwiftUIInUIKitDemo: View {
    @State private var saved = 3
    var body: some View {
        HostedContainer(saved: $saved)
            .navigationTitle("One collection").navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier("capture-ready")
    }
    private struct CollectionCard: View {
        let saved: Int
        let add: () -> Void
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "bookmark.square.fill").font(.system(size: 44)).foregroundStyle(.indigo)
                Text("Good things,\nkept close.").font(.system(.title, design: .serif).bold())
                Text("\(saved) ideas in your collection").foregroundStyle(.secondary)
                Button("Save an idea", systemImage: "plus", action: add).buttonStyle(.borderedProminent)
            }.frame(maxWidth: .infinity, alignment: .leading).padding(24)
                .background(Color(uiColor: .secondarySystemGroupedBackground), in: .rect(cornerRadius: 24))
        }
    }
    private struct HostedContainer: UIViewControllerRepresentable {
        @Binding var saved: Int
        func makeUIViewController(context: Context) -> ContainerController { ContainerController() }
        func updateUIViewController(_ controller: ContainerController, context: Context) {
            controller.render(saved: saved) { saved += 1 }
        }
    }
    private final class ContainerController: UIViewController {
        private var host: UIHostingController<CollectionCard>?
        private var add: () -> Void = {}
        private var saved = 0
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemGroupedBackground
            let heading = UILabel()
            heading.text = "A UIKit screen, with a SwiftUI card."
            heading.font = .preferredFont(forTextStyle: .subheadline)
            heading.textColor = .secondaryLabel; heading.numberOfLines = 0
            heading.adjustsFontForContentSizeCategory = true
            let button = UIButton(configuration: .bordered(), primaryAction: UIAction(title: "Add from UIKit", image: UIImage(systemName: "plus.circle")) { [weak self] _ in self?.add() })
            let hosting = UIHostingController(rootView: CollectionCard(saved: saved, add: { [weak self] in self?.add() }))
            host = hosting
            hosting.view.backgroundColor = .clear
            addChild(hosting)
            for child in [heading, hosting.view!, button] { child.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(child) }
            NSLayoutConstraint.activate([
                heading.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), heading.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
                hosting.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), hosting.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), hosting.view.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 24), hosting.view.heightAnchor.constraint(equalToConstant: 380),
                button.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), button.topAnchor.constraint(equalTo: hosting.view.bottomAnchor, constant: 24)
            ])
            hosting.didMove(toParent: self)
        }
        func render(saved: Int, add: @escaping () -> Void) {
            self.saved = saved; self.add = add
            host?.rootView = CollectionCard(saved: saved, add: { [weak self] in self?.add() })
        }
    }
}

#Preview { NavigationStack { SwiftUIInUIKitDemo() } }
