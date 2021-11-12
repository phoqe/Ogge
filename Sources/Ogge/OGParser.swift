import Foundation
import SwiftSoup

// TODO: Use shared instance of parser to enable setting strict mode.
// TODO: Remove SwiftSoup dependency.
public struct OGParser {
    private static let encoder: JSONEncoder = JSONEncoder()
    private static let decoder: JSONDecoder = JSONDecoder()

    public static func parse(
        html: String
    ) throws -> OGObject {
        let doc = try SwiftSoup.parse(html)

        let ogElements = try doc.select("meta[property~=og:")

        if ogElements.isEmpty() {
            throw OGParserError.noOpenGraphElements // throw or nil?
        }

        // TODO: Allow duplicate pairs.
        let ogs = try Dictionary(ogElements.map {
            (try $0.attr("property"), try $0.attr("content"))
        }) { _, last in last }

        if ogs.isEmpty {
            throw OGParserError.noOpenGraphProps // throw or nil?
        }

        let data = try encoder.encode(ogs)
        let og = try decoder.decode(OGObject.self, from: data)

        return og
    }

    public static func parseOptional(
        html: String
    ) throws -> OGObject? {
        let doc = try SwiftSoup.parse(html)

        let ogElements = try doc.select("meta[property~=og:")

        if ogElements.isEmpty() {
            return nil
        }

        // TODO: Allow duplicate pairs.
        let ogs = try Dictionary(ogElements.map {
            (try $0.attr("property"), try $0.attr("content"))
        }) { _, last in last }

        if ogs.isEmpty {
            return nil
        }

        let data = try encoder.encode(ogs)
        let og = try decoder.decode(OGObject.self, from: data)

        return og
    }
}
