import Foundation
import XCTest

@testable import Ogge

class OGParserTests: XCTestCase {
    func testRequired() async throws {
        let object = try OGParser.parse(html: MockProp.required)

        XCTAssertEqual(object, MockObject.required)
    }
}
