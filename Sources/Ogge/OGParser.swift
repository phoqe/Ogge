import Foundation
import SwiftSoup

/// A parser that can pares HTML containing Open Graph properties into a custom object.
/// The parser uses SwiftSoup internally to process the HTML.
public struct OGParser {
    /// A privately shared instance of a `JSONEncoder`.
    /// Not for use outside of this class.
    private static let encoder: JSONEncoder = JSONEncoder()

    /// A privately shared instance of a `JSONDecoder`.
    /// Not for use outside of this class.
    private static let decoder: JSONDecoder = JSONDecoder()

    /// Parses an HTML string and converts it into a reusable object.
    /// It uses SwiftSoup to parse the HTML and will try to find Open Graph properties regardless of them being within `<head>`.
    /// In the future, there may come an option to strictly adhere to the Open Graph specification.
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

        // Don't waste any more time.
        if elements.isEmpty() {
            return nil
        }

        // All props are arrays in the parser since dictionaries can't hold duplicate keys.
        // Custom objects are not used as a value since such dictionaries don't conform to `Codable`.
        var props: [String: [String]] = [:]

        props.reserveCapacity(elements.count)

        for element in elements {
            let prop = try element.attr("property")
            let content = try element.attr("content")

            // Allow multiple keys to group in an array.
            // Thereby supporting Open Graph arrays.
            if let dupeProp = props[prop],
               let dupeContent = dupeProp.first {
                props[prop] = [dupeContent, content]

                continue
            }

            props[prop] = [content]
        }

        // Avoid unnecessary coding operations.
        if props.isEmpty {
            return nil
        }

        // Encode to a data object. Might be unnecessary but required for `Codable` objects.
        let data = try encoder.encode(props)

        // The object returned has picked values from the array values.
        let object = try decoder.decode(OGObject.self, from: data)

        return object
    }
}
