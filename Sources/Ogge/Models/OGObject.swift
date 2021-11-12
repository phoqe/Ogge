import Foundation

struct OGObject: Codable, Equatable {

    // MARK: Basic Metadata

    let title: String
    let type: String
    let image: URL
    let url: URL

    // MARK: Optional Metadata

    let audio: URL? = nil
    let description: String? = nil
    let determiner: String? = nil
    let locale: String? = nil
    let alternateLocales: [String]? = nil
    let siteName: String? = nil
    let video: URL? = nil

    // TODO: Add custom coding key for the Open Graph format.
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
