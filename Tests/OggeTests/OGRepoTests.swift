import Foundation
import XCTest

@testable import Ogge

class OGRepoTests: XCTestCase {
    @available(macOS 12.0, *)
    func testObject() async throws {
        XCTAssertNoThrow(
            Task {
                try await OGRepo.object(from: MockData.exampleURL)
            }
        )
    }

    func testObjectResult() {
        let object = OGRepo.object(from: MockData.exampleURL, completion: { res in
            switch res {
            case .success(let object):

                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        })
    }
}

