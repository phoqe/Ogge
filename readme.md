# Ogge

Ogge is a convenient and efficient Swift wrapper for the Open Graph Protocol.

## Installation

## Usage

### URL

Ogge can fetch HTML from an URL and parse it.

```swift
let url = URL(string: "https://example.com")!
let object = try await OGRepo.object(from: url)
```

### HTML

Ogge can parse any HTML you throw at it.

```swift
let html = """
<meta property="og:title" content="The Rock">
<meta property="og:type" content="video.movie">
<meta property="og:url" content="https://www.imdb.com/title/tt0117500">
<meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg">
"""
let object = try OGParser.parse(html: html)
```

## License

MIT
