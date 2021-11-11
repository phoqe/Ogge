import Foundation
import XCTest

@testable import Ogge

class OGRepoTests: XCTestCase {
    let url = URL(string: "https://ogp.me")!

    func test() async throws {
        try await OGRepo.object(url: url)
    }
}
