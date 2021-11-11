import Foundation

struct Ogge {

    /// Fetch an Open Graph object.
    ///
    /// - Parameters:
    ///    - url: The URL of the website containing Open Graph properties.
    ///
    /// - Returns: An Open Graph object containing properties found on the website.
    ///
    static func fetch(url: URL) async throws -> OGObject {
        return try await OGRepo.object(url: url)
    }
}
