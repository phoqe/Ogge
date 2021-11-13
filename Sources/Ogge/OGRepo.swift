import Foundation

public struct OGRepo {
    private static let session: URLSession = URLSession.shared
    
    public static func object(from url: URL) async throws -> OGObject? {
        let (data, _) = try await session.data(from: url)

        guard let html = String(data: data, encoding: .ascii) else {
            throw OGRepoError.invalidHTML
        }

        return try OGParser.parse(html: html)
    }
}
