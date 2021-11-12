import Foundation

@testable import Ogge

struct MockObject {
    static let required = OGObject(title: "The Rock", type: "video.movie", image: URL(string: "https://ia.media-imdb.com/images/rock.jpg")!, url: URL(string: "https://www.imdb.com/title/tt0117500")!)

    static let requiredAndOptional = OGObject(title: "The Rock", type: "video.movie", image: URL(string: "https://ia.media-imdb.com/images/rock.jpg")!, url: URL(string: "https://www.imdb.com/title/tt0117500")!, audio: URL(string: "https://example.com/bond/theme.mp3")!, description: "Sean Connery found fame and fortune as the suave, sophisticated British agent, James Bond.", determiner: "the", locale: "en_GB", alternateLocales: ["fr_FR", "es_ES"], siteName: "IMDb", video: URL(string: "https://example.com/bond/trailer.swf"))
}
