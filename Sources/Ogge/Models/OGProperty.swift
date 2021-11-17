import Foundation

enum OGProperty: String, Codable {

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
    case alternateLocale = "og:locale:alternate"
    case siteName = "og:site_name"
    case video = "og:video"
}
