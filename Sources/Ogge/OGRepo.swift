import Foundation
import OSLog

public struct OGRepo {
    // TODO: Replace with shared user session for caching, i.e., the user mounts a session and supplies it.
    private static let session = URLSession.shared
    
    @available(iOS 15.0, *)
    public static func object(from url: URL) async throws -> OGObject? {
        let (data, _) = try await session.data(from: url)

        guard let html = String(data: data, encoding: .ascii) else {
            return nil
        }

        return try OGParser.parse(html: html)
    }

    public static func object(from url: URL, completion: @escaping (Result<OGObject?, Error>) -> Void) {
        session.dataTask(with: url) { data, res, error in
            if let error = error {
                completion(.failure(error))

                return
            }

            guard let data = data,
                  let html = String(data: data, encoding: .ascii) else {
                      completion(.success(nil))

                      return
                  }

            var object: OGObject?

            do {
                object = try OGParser.parse(html: html)
            } catch {
                completion(.failure(error))
            }

            completion(.success(object))
        }
    }
}
