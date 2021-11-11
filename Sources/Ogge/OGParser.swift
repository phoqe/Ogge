import Foundation
import SwiftSoup

enum OGParserError: Error {
    case noHeadElement
}

// TODO: Use shared instance of parser to enable setting strict mode.
struct OGParser {
    private static let encoder: JSONEncoder = JSONEncoder()
    private static let decoder: JSONDecoder = JSONDecoder()

    static func parse(html: String) throws -> OGObject {
        let doc = try SwiftSoup.parse(html)

        // According to the Open Graph protocol, the meta tags should reside within the head element.
        // TODO: Add some form of strict mode which allows bypassing this condition.
//        guard let headElement = doc.head() else {
//            throw OGParserError.noHeadElement
//        }

        let ogElements = try doc.select("meta[property~=og:")
        let ogs = try Dictionary(ogElements.map {
            (try $0.attr("property"), try $0.attr("content"))
        }) { _, last in last }
        let data = try encoder.encode(ogs)
        let og = try decoder.decode(OGObject.self, from: data)

        return og
    }
}
