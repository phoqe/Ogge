import Foundation
import OSLog

public struct OGRepo {
    private static let logger = Logger(category: String(describing: OGRepo.self))

    // TODO: Replace with shared user session for caching, i.e., the user mounts a session and supplies it.
    private static let session = URLSession.shared
    
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

    public static func object(from url: URL, completion: @escaping (Result<OGObject?, Error>) -> Void) {
        logger.trace("object(url:completion:)")

        session.dataTask(with: url) { data, res, error in
            if let error = error {
                logger.error("\(error.localizedDescription)")

                completion(.failure(error))

                return
            }

            logger.debug("no error")

            guard let data = data,
                  let html = String(data: data, encoding: .ascii) else {
                      logger.error("no data or invalid html")

                      completion(.success(nil))

                      return
                  }

            logger.debug("valid html")

            var object: OGObject?

            do {
                object = try OGParser.parse(html: html)
            } catch {
                logger.error("\(error.localizedDescription)")

                completion(.failure(error))
            }

            logger.debug("valid object")

            completion(.success(object))
        }
    }
}
