import Foundation
import OSLog

public struct OGRepo {
    // TODO: Replace with user-defined cache. Only here for development.
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default

        config.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: config)
    }()
    private static let logger = Logger(category: String(describing: OGRepo.self))

    @available(iOS 15.0, *)
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
