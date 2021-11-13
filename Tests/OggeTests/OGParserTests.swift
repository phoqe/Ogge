import Foundation
import XCTest

@testable import Ogge

class OGParserTests: XCTestCase {
    func testBasic() throws {
        let object = try OGParser.parse(html: MockProp.basic)
        let mockObject = MockObject.basic

        XCTAssertEqual(object, mockObject)
    }

    func testOptional() throws {
        let object = try OGParser.parse(html: MockProp.optional)
        let mockObject = MockObject.optional

        XCTAssertEqual(object, mockObject)
    }

    func testBasicAndOptional() throws {
        let object = try OGParser.parse(html: MockProp.basicAndOptional)
        let mockObject = MockObject.basicAndOptional

        XCTAssertEqual(object, MockObject.basicAndOptional)
    }
}
