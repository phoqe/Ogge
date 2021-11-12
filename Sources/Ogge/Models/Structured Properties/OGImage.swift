import Foundation

struct OGImage: Codable {
    let url: URL
    let secureURL: URL?
    let type: String?
    let width: Int?
    let height: Int?
    let alt: String?
}
