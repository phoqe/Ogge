import Foundation
import XCTest

@testable import Ogge

class OGParserTests: XCTestCase {
    func testRequired() throws {
        let object = try OGParser.parse(html: MockProp.required)
        let mockObject = MockObject.required

        XCTAssertEqual(object, mockObject)
    }

    func testOptional() throws {
        XCTAssertThrowsError(try OGParser.parse(html: MockProp.optional))
    }

    func testRequiredAndOptional() throws {
        let object = try OGParser.parse(html: MockProp.requiredAndOptional)

        XCTAssertEqual(object, MockObject.requiredAndOptional)
    }
}
