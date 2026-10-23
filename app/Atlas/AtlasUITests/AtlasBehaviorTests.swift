import XCTest

@MainActor
final class AtlasBehaviorTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSheetDetentExpansionAndCollapseChangeContent() {
        let app = launch("sheet-detents")
        defer { app.terminate() }
        tap(app.buttons["present"])

        XCTAssertFalse(app.staticTexts["Harbor steps"].exists)
        tap(app.buttons["See route details"])
        XCTAssertTrue(app.staticTexts["Harbor steps"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Old lighthouse"].exists)
        tap(app.buttons["Show summary"])

        XCTAssertTrue(app.buttons["See route details"].waitForExistence(timeout: 5))
        assertDisappears(app.staticTexts["Harbor steps"])
        tap(app.buttons["Done"])
        XCTAssertTrue(app.buttons["present"].waitForExistence(timeout: 5))
    }

    func testCancellingEditedSheetKeepsSavedTitle() {
        let app = launch("sheet-dismissal")
        defer { app.terminate() }
        let originalTitle = "The coastal path"
        tap(app.buttons["present"])
        let field = app.textFields["Title"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertEqual(field.value as? String, originalTitle)
        field.tap()
        field.typeText(" discarded")
        XCTAssertNotEqual(field.value as? String, originalTitle)

        tap(app.buttons["Cancel"])
        tap(app.buttons["Discard changes"])
        assertDisappears(field)
        XCTAssertTrue(app.staticTexts[originalTitle].waitForExistence(timeout: 5))

        tap(app.buttons["present"])
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertEqual(field.value as? String, originalTitle)
        tap(app.buttons["Cancel"])
        assertDisappears(field)
    }

    func testSavingSheetPersistsTitleAcrossPresentations() {
        let app = launch("sheet-dismissal")
        defer { app.terminate() }
        tap(app.buttons["present"])
        let field = app.textFields["Title"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        field.typeText(" revised")
        // Read the edited value so the test does not depend on where a tap places the caret.
        let editedTitle = field.value as? String ?? ""
        XCTAssertTrue(editedTitle.contains("revised"))
        tap(app.buttons["Save"])
        assertDisappears(field)
        XCTAssertTrue(app.staticTexts[editedTitle].waitForExistence(timeout: 5))

        tap(app.buttons["present"])
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertEqual(field.value as? String, editedTitle)
        tap(app.buttons["Cancel"])
        assertDisappears(field)
        XCTAssertTrue(app.staticTexts[editedTitle].exists)
    }

    func testNavigationPushAndReturnRecoverCollectionRoot() {
        let app = launch("navigation-push-pop")
        defer { app.terminate() }
        tap(app.buttons["Coastal walks"])
        XCTAssertTrue(app.buttons["Open itinerary"].waitForExistence(timeout: 5))
        tap(app.buttons["Open itinerary"])
        XCTAssertTrue(app.staticTexts["Your itinerary"].waitForExistence(timeout: 5))

        let itineraryBar = app.navigationBars["Itinerary"]
        XCTAssertTrue(itineraryBar.waitForExistence(timeout: 5))
        // Select the native destination back button, not the separate Atlas exit control.
        tap(app.buttons["BackButton"])
        tap(app.buttons["Return to Journeys"])
        XCTAssertTrue(app.buttons["City weekends"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Mountain escapes"].exists)
        XCTAssertFalse(app.buttons["Return to Journeys"].exists)
        tap(app.buttons["back-to-atlas"])
        XCTAssertTrue(app.navigationBars["Atlas"].waitForExistence(timeout: 5))
    }

    func testDeepLinkBuildsPathAndCanReturnToExplore() {
        let app = launch("navigation-path-restoration")
        defer { app.terminate() }
        XCTAssertTrue(app.buttons["back-to-atlas"].waitForExistence(timeout: 5))

        // A scene may restore either destination from an earlier manual run.
        if app.buttons["Back to Explore"].exists {
            tap(app.buttons["Back to Explore"])
        } else if app.buttons["Point Reyes"].exists {
            tap(app.buttons["Point Reyes"])
            tap(app.buttons["Back to Explore"])
        }
        tap(app.buttons["Clear saved path"])
        tap(app.buttons["Open saved place"])
        XCTAssertTrue(app.staticTexts["Point Reyes"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.navigationBars["Saved place"].exists)
        tap(app.buttons["Back to Explore"])
        XCTAssertTrue(app.buttons["Northern coast"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Open saved place"].exists)
        XCTAssertFalse(app.buttons["Back to Explore"].exists)
    }

    func testTabsKeepIndependentNavigationStacks() {
        let app = launch("tab-navigation-stacks")
        defer { app.terminate() }
        tap(app.buttons["Small adventures"])
        tap(app.buttons["Open another page"])
        let libraryDestination = "A page inside Small adventures"
        XCTAssertTrue(app.staticTexts[libraryDestination].firstMatch.waitForExistence(timeout: 5))

        tap(app.buttons["Favorites"].firstMatch)
        tap(app.buttons["Quiet mornings"])
        XCTAssertTrue(app.staticTexts["Quiet mornings"].firstMatch.waitForExistence(timeout: 5))
        tap(app.buttons["Library"].firstMatch)
        XCTAssertTrue(app.staticTexts[libraryDestination].firstMatch.waitForExistence(timeout: 5))
        tap(app.buttons["Favorites"].firstMatch)
        XCTAssertTrue(app.staticTexts["Quiet mornings"].firstMatch.waitForExistence(timeout: 5))

        tap(app.buttons["Return to this tab’s root"])
        XCTAssertTrue(app.buttons["By the water"].waitForExistence(timeout: 5))
        tap(app.buttons["Library"].firstMatch)
        XCTAssertTrue(app.staticTexts[libraryDestination].firstMatch.waitForExistence(timeout: 5))
    }

    private func launch(_ entry: String) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["--entry", entry, "-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 10))
        return app
    }

    private func tap(_ element: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.waitForExistence(timeout: 5), "Missing control: \(element)", file: file, line: line)
        element.tap()
    }

    private func assertDisappears(_ element: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        let absent = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: element)
        XCTAssertEqual(XCTWaiter.wait(for: [absent], timeout: 5), .completed,
                       "Element remained after dismissal: \(element)", file: file, line: line)
    }
}
