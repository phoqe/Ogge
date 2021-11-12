import Foundation

struct OGObject: Codable, Equatable {

    // MARK: Basic Metadata

    let title: String
    let type: String
    let image: URL
    let url: URL

    // MARK: Optional Metadata

    let audio: URL?
    let description: String?
    let determiner: String?
    let locale: String? // TODO: Default is `en_US`.
    let alternateLocales: [String]? // FIXME: Error when decoding, expects array but got string.
    let siteName: String?
    let video: URL?

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

    init(
        // Basic Metadata
        title: String,
        type: String,
        image: URL,
        url: URL,

        // Optional Metadata
        audio: URL? = nil,
        description: String? = nil,
        determiner: String? = nil,
        locale: String? = nil,
        alternateLocales: [String]? = nil,
        siteName: String? = nil,
        video: URL? = nil
    ) {
        // Basic Metadata
        self.title = title
        self.type = type
        self.image = image
        self.url = url

        // Optional Metadata
        self.audio = audio
        self.description = description
        self.determiner = determiner
        self.locale = locale
        self.alternateLocales = alternateLocales
        self.siteName = siteName
        self.video = video
    }
}
