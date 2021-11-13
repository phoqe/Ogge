import Foundation
import SwiftSoup
import OSLog

// TODO: Remove SwiftSoup dependency.
public struct OGParser {
    private static let encoder: JSONEncoder = JSONEncoder()
    private static let decoder: JSONDecoder = JSONDecoder()
    private static let logger = Logger(category: String(describing: OGParser.self))

    public static func parse(
        html: String,
        requireHead: Bool = false,
        inferFromHTML: Bool = false
    ) throws -> OGObject? {
        logger.trace("parse(html:requireHead:inferFromHTML:)")

        let document: Document = try SwiftSoup.parse(html)
        let elements: Elements = try document.select("meta[property~=og:")

        // Don't waste any more resources.
        if elements.isEmpty() {
            logger.info("no elements")

            return nil
        }

        logger.debug("with elements")

        // TODO: Add support for Open Graph arrays.
        var props: [String: String] = [:]

        for element in elements {
            let property = try element.attr("property")
            let content = try element.attr("content")

            props[property] = content
        }

        // Avoid unnecessary coding operations.
        if props.isEmpty {
            logger.info("no props")

            return nil
        }

        logger.debug("with props")

        let data = try encoder.encode(props)
        let object = try decoder.decode(OGObject.self, from: data)

        return object
    }
}
