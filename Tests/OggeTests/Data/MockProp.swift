import Foundation

@testable import Ogge

struct MockProp {
    static let required = """
    <meta property="og:title" content="The Rock">
    <meta property="og:type" content="video.movie">
    <meta property="og:url" content="https://www.imdb.com/title/tt0117500">
    <meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg">
    """

    static let optional = """
    <meta property="og:title" content="The Rock">
    <meta property="og:type" content="video.movie">
    <meta property="og:url" content="https://www.imdb.com/title/tt0117500/">
    <meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg">
    <meta property="og:audio" content="https://example.com/bond/theme.mp3">
    <meta property="og:description" content="Sean Connery found fame and fortune as the suave, sophisticated British agent, James Bond.">
    <meta property="og:determiner" content="the">
    <meta property="og:locale" content="en_GB">
    <meta property="og:locale:alternate" content="fr_FR">
    <meta property="og:locale:alternate" content="es_ES">
    <meta property="og:site_name" content="IMDb">
    <meta property="og:video" content="https://example.com/bond/trailer.swf">
    """
}
