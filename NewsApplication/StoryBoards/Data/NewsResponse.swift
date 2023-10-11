
import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

