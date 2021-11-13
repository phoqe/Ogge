import Foundation
import SwiftSoup

// TODO: Remove SwiftSoup dependency.
public struct OGParser {
    private static let encoder: JSONEncoder = JSONEncoder()
    private static let decoder: JSONDecoder = JSONDecoder()

    public static func parse(
        html: String,
        requireHead: Bool = false,
        inferFromHTML: Bool = false
    ) throws -> OGObject {
        let document: Document = try SwiftSoup.parse(html)
        let elements: Elements = try document.select("meta[property~=og:")
        var props: [String: String] = [:]

        for element in elements {
            let property = try element.attr("property")
            let content = try element.attr("content")

            props[property] = content
        }

        let data = try encoder.encode(props)
        let object = try decoder.decode(OGObject.self, from: data)

        return object
    }
}
