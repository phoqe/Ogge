import Foundation
import SwiftSoup
import OSLog

// TODO: Remove SwiftSoup dependency.
public struct OGParser {
    private static let encoder: JSONEncoder = JSONEncoder()
    private static let decoder: JSONDecoder = JSONDecoder()

    @available(iOS 15.0, *)
    public static func parse(
        html: String,
        requireHead: Bool = false,
        inferFromHTML: Bool = false
    ) throws -> OGObject? {
        let document: Document = try SwiftSoup.parse(html)
        let elements: Elements = try document.select("meta[property~=og:")

        // Don't waste any more resources.
        if elements.isEmpty() {
            return nil
        }

        // TODO: Add support for Open Graph arrays.
        var props: [String: String] = [:]

        for element in elements {
            let property = try element.attr("property")
            let content = try element.attr("content")

            props[property] = content
        }

        // Avoid unnecessary coding operations.
        if props.isEmpty {
            return nil
        }

        let data = try encoder.encode(props)
        let object = try decoder.decode(OGObject.self, from: data)

        return object
    }
}
