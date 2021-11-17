import Foundation
import SwiftSoup
import OSLog

// TODO: Remove SwiftSoup dependency.
public struct OGParser {
    /// A privately shared instance of a `JSONEncoder`.
    /// Not for use outside of this class.
    private static let encoder: JSONEncoder = JSONEncoder()

    /// A privately shared instance of a `JSONDecoder`.
    /// Not for use outside of this class.
    private static let decoder: JSONDecoder = JSONDecoder()

    /// Parses an HTML string and converts it into a reusable object.
    ///
    /// - Parameters:
    ///    - html: Must be valid HTML. Ogge will try to parse any HTML you throw at it.
    ///
    /// - Returns: A reusable object containing the properties found in the HTML.
    ///
    public static func parse(
        html: String
    ) throws -> OGObject? {
        let document: Document = try SwiftSoup.parse(html)
        let elements: Elements = try document.select("meta[property~=og:")

        // Don't waste any more resources.
        if elements.isEmpty() {
            return nil
        }

        var props: [String: [String]] = [:]

        for element in elements {
            let property = try element.attr("property")
            let content = try element.attr("content")

            // Allow multiple keys to group in an array.
            // Thereby supporting Open Graph arrays.
            if let existingProperty = props[property],
               let arrayProperty = existingProperty.first {
                props[property] = [arrayProperty, content]

                continue
            }

            props[property] = [content]
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
