import SwiftUI
import StoreKit
import Foundation

struct StoreKitProductViewDemo: View {
    @State private var product: Product?
    @State private var style = "Large"
    @State private var loading = true
    @State private var attempt = 0
    @State private var feedback: String?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Make room for your ideas.").font(.system(.largeTitle, design: .serif).bold())
                if let product {
                    Group {
                        switch style {
                        case "Compact": productCard(product).productViewStyle(.compact)
                        case "Regular": productCard(product).productViewStyle(.regular)
                        default: productCard(product).productViewStyle(.large)
                        }
                    }.accessibilityIdentifier("storekit-products-loaded")
                    if !isCapturing {
                        Picker("Product style", selection: $style) { ForEach(["Compact", "Regular", "Large"], id: \.self) { Text($0) } }.pickerStyle(.segmented)
                    }
                    if let feedback { Text(feedback).font(.subheadline).foregroundStyle(.secondary) }
                } else if loading { ProgressView("Loading local product…").frame(maxWidth: .infinity).padding(40) }
                else {
                    ContentUnavailableView("Local product unavailable", systemImage: "bag", description: Text("Run with AtlasPurchases.storekit enabled in Xcode."))
                    Button("Retry loading") { attempt += 1 }
                }
            }.padding(28)
        }
        .task(id: attempt) {
            loading = true
            product = try? await Product.products(for: ["dev.iosdesignatlas.fixture.notes"]).first
            loading = false
        }
        .onInAppPurchaseCompletion { _, result in
            switch result {
            case .success(.success(.verified(let transaction))): feedback = "Field Notes Pack unlocked for this session."; await transaction.finish()
            case .success(.success(.unverified(_, _))): feedback = "The purchase could not be verified."
            case .success(.pending): feedback = "The purchase is awaiting approval."
            case .success(.userCancelled): feedback = "Purchase cancelled."
            case .failure: feedback = "The purchase could not be completed."
            @unknown default: feedback = "The purchase status changed."
            }
        }
        .navigationTitle("Field notes").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func productCard(_ product: Product) -> some View {
        ProductView(product) {
            Image(systemName: "book.closed.fill").font(.system(size: 66)).foregroundStyle(.white)
                .frame(width: 150, height: 150).background(.teal.gradient, in: .rect(cornerRadius: 32))
        }
    }
}

#Preview { NavigationStack { StoreKitProductViewDemo() } }
