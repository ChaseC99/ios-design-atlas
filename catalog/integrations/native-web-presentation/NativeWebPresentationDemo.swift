import SwiftUI
import WebKit
import SafariServices

struct NativeWebPresentationDemo: View {
    @State private var browser = false
    @State private var webLoaded = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Native and web").font(.largeTitle.bold())
                    Text("A local page, framed by native controls.").foregroundStyle(.secondary)
                }
                AtlasLocalWebPage(loaded: $webLoaded).frame(height: 330)
                    .clipShape(.rect(cornerRadius: 24))
                    .overlay { RoundedRectangle(cornerRadius: 24).strokeBorder(.secondary.opacity(0.2)) }
                Label("Embedded WKWebView", systemImage: "rectangle.inset.filled").font(.subheadline).foregroundStyle(.secondary)
                Divider()
                Button { browser = true } label: {
                    Label("Open Apple design in Safari", systemImage: "safari").frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
            }.padding(24)
        }
        .sheet(isPresented: $browser) { AtlasSafariPage() }
        .navigationTitle("Web presentation").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier(webLoaded ? "capture-ready" : "web-loading")
    }
}

private struct AtlasLocalWebPage: UIViewRepresentable {
    @Binding var loaded: Bool
    func makeCoordinator() -> Coordinator { Coordinator(loaded: $loaded) }
    final class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var loaded: Bool
        init(loaded: Binding<Bool>) { _loaded = loaded }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { loaded = true }
    }
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.isOpaque = false
        view.scrollView.isScrollEnabled = false
        view.loadHTMLString("""
        <!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1">
        <style>body{font-family:-apple-system;margin:0;padding:28px;background:#edf6f3;color:#173f39}small{letter-spacing:3px}h1{font-size:34px;line-height:1.1;margin:22px 0}p{font-size:17px;line-height:1.5;color:#42635e}</style></head>
        <body><small>FIELD NOTES</small><h1>Take the<br>scenic route.</h1><p>Small discoveries are waiting<br>just around the corner.</p></body></html>
        """, baseURL: nil)
        return view
    }
    func updateUIView(_ view: WKWebView, context: Context) {}
}
private struct AtlasSafariPage: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: URL(string: "https://developer.apple.com/design/")!)
    }
    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}

#Preview { NavigationStack { NativeWebPresentationDemo() } }
