import XCTest

@MainActor
final class AtlasUITests: XCTestCase {
    override func setUpWithError() throws { continueAfterFailure = false }

    private func launch(_ id: String) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["--entry", id, "-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
        app.launch()
        XCTAssertTrue(app.buttons["present"].waitForExistence(timeout: 10), "Missing trigger for \(id)")
        return app
    }

    func testCaptureAlerts() {
        let examples = ["alert-actions", "alert-text-fields"]
        for id in examples {
            let app = XCUIApplication()
            app.launchArguments = ["--entry", id, "--capture", "-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
            app.launch()
            XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 10), "Missing alert for \(id)")
            XCTAssertFalse(app.buttons["present"].exists)
            XCTAssertFalse(app.navigationBars.firstMatch.exists)
            // Allow the system presentation and keyboard animation to settle before recording.
            Thread.sleep(forTimeInterval: 1.5)
            let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
            attachment.name = "atlas--\(id)--clean"
            attachment.lifetime = .keepAlways
            add(attachment)
            app.terminate()
        }
    }

    func testAlertCancelPreservesState() {
        let app = launch("alert-actions")
        app.buttons["present"].tap()
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 5))
        app.alerts.buttons["Cancel"].tap()
        XCTAssertTrue(app.staticTexts["Cancelled"].waitForExistence(timeout: 3))
    }

    func testRenameSavesAndCancelKeepsOriginal() {
        let app = launch("alert-text-fields")
        app.buttons["present"].tap()
        let field = app.alerts.textFields.firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        let original = field.value as? String ?? ""
        field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: original.count))
        field.typeText("Research notes")
        app.alerts.buttons["Save"].tap()
        let savedName = app.staticTexts.matching(NSPredicate(format: "label == %@ OR label == %@", "Research notes", "Name, Research notes")).firstMatch
        XCTAssertTrue(savedName.waitForExistence(timeout: 3))
        app.buttons["present"].tap()
        app.alerts.textFields.firstMatch.typeText(" discarded")
        app.alerts.buttons["Cancel"].tap()
        XCTAssertTrue(savedName.exists)
    }

    func testPopoverCanDismissAndReopen() {
        let app = launch("popover-anchors")
        app.buttons["present"].tap()
        XCTAssertTrue(app.buttons["Done"].waitForExistence(timeout: 5))
        app.buttons["Done"].tap()
        app.buttons["present"].tap()
        XCTAssertTrue(app.buttons["Done"].waitForExistence(timeout: 5))
    }
}
