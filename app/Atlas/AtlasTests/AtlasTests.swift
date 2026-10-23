import XCTest
@testable import Atlas

final class AtlasTests: XCTestCase {
    func testCatalogIDsAreUniqueAndSearchable() {
        let entries = AtlasCatalog.entries
        XCTAssertEqual(Set(entries.map(\.id)).count, entries.count)
        XCTAssertTrue(entries.allSatisfy { !$0.title.isEmpty && !$0.apis.isEmpty })
    }
}
