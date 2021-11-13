import Foundation

public struct OGObject: Codable, Equatable {

    // MARK: Basic Metadata

    let title: String
    let type: String
    let image: URL
    let url: URL

    // MARK: Optional Metadata

    let audio: URL?
    let description: String?
    let determiner: String?
    var locale: String = "en_US"
    var alternateLocales: [String] = []
    let siteName: String?
    let video: URL?

    // TODO: Add custom coding key for the Open Graph format to avoid typing out the keys manually.
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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Basic Metadata
        title = try container.decode(String.self, forKey: .title)
        type = try container.decode(String.self, forKey: .type)
        image = try container.decode(URL.self, forKey: .image)
        url = try container.decode(URL.self, forKey: .url)

        // Optional Metadata
        audio = try container.decodeIfPresent(URL.self, forKey: .audio)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        determiner = try container.decodeIfPresent(String.self, forKey: .determiner)
        locale = try container.decodeIfPresent(String.self, forKey: .locale) ?? locale

        if let alternateLocales = try container.decodeIfPresent(String.self, forKey: .alternateLocales) {
            self.alternateLocales.append(alternateLocales)
        }

        siteName = try container.decodeIfPresent(String.self, forKey: .siteName)
        video = try container.decodeIfPresent(URL.self, forKey: .video)
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
        locale: String? = "en_US",
        alternateLocales: [String] = [],
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

        if let locale = locale {
            self.locale = locale
        }

        self.alternateLocales = alternateLocales
        self.siteName = siteName
        self.video = video
    }
}
