# Ogge

Ogge is a convenient and efficient Swift wrapper for the Open Graph Protocol.

## Motivation

Ogge was built in parallel with a newsreader app.
I wanted to fetch metadata from a URL and display the image of an article in the newsfeed.
There was another great project, [OpenGraph](https://github.com/satoshi-takano/OpenGraph), but it didn’t meet my demands since I wanted the Open Graph properties returned as an object.

## Installation

Ogge is available as a Swift Package:

```swift
.package(url: "https://github.com/phoqe/Ogge.git", from: "master")
```

## Usage

You can use Ogge in multiple ways depending on the available data.

### URL

`OGRepo` can fetch HTML from a URL and parse it into an `OGObject`:

#### [`async/await`](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

```swift
let url = URL(string: "https://example.com")!
let object = try await OGRepo.object(from: url)
```

#### [`Result`](https://developer.apple.com/documentation/swift/result)

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

`OGParser` can parse HTML and parse it into an `OGObject`:

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
