import Foundation

/// Ogge is a convenient and efficient wrapper for the Open Graph Protocol.
/// It relies on `async/await` along with the `Codable` protocol for use in modern apps.
public struct Ogge {

    ///
    /// Fetch Open Graph properties from a website and parse them into an Open Graph object.
    ///
    /// - Parameters:
    ///    - url: The URL of the website containing Open Graph properties.
    ///
    /// - Returns: An Open Graph object containing properties found on the website.
    ///
    public static func object(from url: URL) async throws -> OGObject {
        return try await OGRepo.object(url: url)
    }

    ///
    /// Fetch Open Graph properties from a website and parse them into an Open Graph object.
    ///
    /// - Parameters:
    ///    - url: The URL of the website containing Open Graph properties.
    ///
    /// - Returns: An Open Graph object containing properties found on the website.
    ///
    public static func objectOptional(from url: URL) async throws -> OGObject? {
        return try await OGRepo.objectOptional(url: url)
    }
}
