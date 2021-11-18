import Foundation
import OSLog

/// The `OGRepo` contain static methods for retrieving HTML from a URL.
/// You can customize the `URLSession` it uses by querying `session`.
/// The repo supports `async/await` as well as the `Result` API.
public struct OGRepo {
    /// A shared `URLSession` Ogge uses to fetch HTML from URLs.
    /// The default `requestCachePolicy` is `returnCacheDataElseLoad`.
    /// You are free to modify the configuration to your liking.
    public static var session: URLSession {
        let config = URLSessionConfiguration.default

        config.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: config)
    }

    /// Fetches the HTML as a string from the URL to parse it and finally convert it to a reusable Open Graph object.
    ///
    /// - Parameters:
    ///    - url: URL to fetch HTML from. Should contain Open Graph properties but no biggie if it doesn't.
    ///
    /// - Throws: The method throws when it can't fetch or convert the HTML.
    ///
    /// - Returns: The Open Graph properties compiled into a reusable object.
    ///
    @available(iOS 15.0, macOS 12.0, *)
    public static func object(from url: URL) async throws -> OGObject? {
        let (data, _) = try await session.data(from: url)

        guard let html = String(data: data, encoding: .ascii) else {
            return nil
        }

        return try OGParser.parse(html: html)
    }

    /// Fetches the HTML as a string from the URL to parse it and finally convert it to a reusable Open Graph object.
    ///
    /// - Parameters:
    ///    - url: URL to fetch HTML from. Should contain Open Graph properties but no biggie if it doesn't.
    ///    - completion: Completion handler for handling the error and value.
    ///
    /// - Returns: The Open Graph properties compiled into a reusable object.
    ///
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
