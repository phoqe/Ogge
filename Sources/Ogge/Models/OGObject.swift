import Foundation

public struct OGObject: Codable, Equatable {

    // MARK: Basic Metadata

    public var title: String? = nil
    public var type: String? = nil
    public var image: URL? = nil
    public var url: URL? = nil

    // MARK: Optional Metadata

    public var audio: URL? = nil
    public var description: String? = nil
    public var determiner: String? = nil
    public var locale: String = "en_US"
    public var alternateLocales: [String] = []
    public var siteName: String? = nil
    public var video: URL? = nil

    // TODO: Add custom coding key for the Open Graph format to avoid typing out the keys manually.
    private enum CodingKeys: String, CodingKey {

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
        title = try container.decodeIfPresent(String.self, forKey: .title)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        image = try container.decodeIfPresent(URL.self, forKey: .image)
        url = try container.decodeIfPresent(URL.self, forKey: .url)

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

    public init(
        // Basic Metadata
        title: String? = nil,
        type: String? = nil,
        image: URL? = nil,
        url: URL? = nil,

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
