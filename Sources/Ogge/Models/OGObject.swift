import Foundation

struct OGObject: Codable {

    // MARK: Basic Metadata

    let title: String
    let type: String
    let image: URL
    let url: URL

    // MARK: Optional Metadata

    let audio: URL?
    let description: String?
    let determiner: String?
    let locale: String?
    let alternateLocales: [String]?
    let siteName: String?
    let video: URL?

    enum CodingKeys: String, CodingKey {

        // MARK: Basic Metadata

        case title = "og:title"
        case type = "og:type"
        case image = "og:image"
        case url = "og:url"

        // MARK: Optional Metadata

        case audio = "og:audio"
        case description = "og:description"
        case determiner = "og:determiner"
        case locale = "og:locale"
        case alternateLocales = "og:locale:alternate"
        case siteName = "og:site_name"
        case video = "og:video"
    }
}
