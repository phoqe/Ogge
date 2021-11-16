# Ogge

Ogge is a convenient and efficient Swift wrapper for the Open Graph Protocol.

## Installation

## Usage

### URL

Ogge can fetch HTML from a URL and parse it into an `OGObject`:

#### `async/await`

```swift
let url = URL(string: "https://example.com")!
let object = try await OGRepo.object(from: url)
```

#### `Result`

```swift
let url = URL(string: "https://example.com")!

OGRepo.object(from: url, completion: { result in
    switch (result) {
    case .failure(let error):
        
        break
        
    case .success(let object):
        
        break
    }
})
```

### HTML

Ogge can parse HTML and parse it into an `OGObject`:

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
