import SwiftUI
import StoreKit
import Foundation

struct StoreKitStoreViewDemo: View {
    @State private var products: [Product] = []
    @State private var loading = true
    @State private var attempt = 0
    @State private var feedback: String?
    private let ids = ["dev.iosdesignatlas.fixture.notes", "dev.iosdesignatlas.fixture.icons", "dev.iosdesignatlas.fixture.colors"]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Small additions.\nA little more you.").font(.system(.largeTitle, design: .serif).bold())
                Text("Make your collection feel like home.").foregroundStyle(.secondary)
            }.padding(24)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier(products.count == ids.count ? "storekit-products-loaded" : "storekit-products-loading")
            if products.count == ids.count {
                StoreView(products: products) { product in
                    Image(systemName: symbol(product.id)).font(.system(size: 34)).foregroundStyle(.white)
                        .frame(width: 78, height: 78).background(color(product.id).gradient, in: .rect(cornerRadius: 20))
                }
                .productViewStyle(.compact)
                .storeButton(.hidden, for: .cancellation)
            } else if loading { ProgressView("Loading local products…").frame(maxWidth: .infinity, maxHeight: .infinity) }
            else {
                ContentUnavailableView("Local products unavailable", systemImage: "bag", description: Text("Run with AtlasPurchases.storekit enabled in Xcode."))
                Button("Retry loading") { attempt += 1 }.padding(24)
            }
            if let feedback { Text(feedback).font(.footnote).foregroundStyle(.secondary).padding(24) }
        }
        .task(id: attempt) {
            loading = true
            let fetched = (try? await Product.products(for: ids)) ?? []
            products = ids.compactMap { id in fetched.first { $0.id == id } }
            loading = false
        }
        .onInAppPurchaseCompletion { product, result in
            switch result {
            case .success(.success(.verified(let transaction))): feedback = "\(product.displayName) unlocked for this session."; await transaction.finish()
            case .success(.pending): feedback = "Awaiting purchase approval."
            case .success(.userCancelled): feedback = "Purchase cancelled."
            default: feedback = "No verified purchase was delivered."
            }
        }
        .navigationTitle("The collection shop").navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("capture-ready")
    }
    private func symbol(_ id: String) -> String { id.hasSuffix("notes") ? "book.closed.fill" : id.hasSuffix("icons") ? "leaf.fill" : "paintpalette.fill" }
    private func color(_ id: String) -> Color { id.hasSuffix("notes") ? .teal : id.hasSuffix("icons") ? .orange : .indigo }
}

#Preview { NavigationStack { StoreKitStoreViewDemo() } }
