import Foundation
import OSLog

public struct OGRepo {
    private static let session: URLSession = URLSession.shared
    private static let logger = Logger(category: String(describing: OGRepo.self))
    
    public static func object(from url: URL) async throws -> OGObject? {
        logger.trace("object(url:)")

        let (data, _) = try await session.data(from: url)

        guard let html = String(data: data, encoding: .ascii) else {
            logger.error("invalid html")

            return nil
        }

        logger.debug("valid html")

        return try OGParser.parse(html: html)
    }
}
