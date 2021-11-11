// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Ogge",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Ogge",
            targets: ["Ogge"]),
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.3.3")
    ],
    targets: [
        .target(
            name: "Ogge",
            dependencies: ["SwiftSoup"]),
        .testTarget(
            name: "OggeTests",
            dependencies: ["Ogge"]),
    ]
)
