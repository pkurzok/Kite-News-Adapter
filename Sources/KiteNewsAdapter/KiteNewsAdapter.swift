import Foundation
import OSLog

/// Protocol defining the interface for fetching Kagi News data
public protocol KiteNewsAdapterProtocol {
    /// Fetches the latest available news categories
    /// - Returns: An array of categories containing category metadata including read counts and cluster counts
    /// - Throws: An error if the network request fails or if decoding fails
    func fetchLatestCategories() async throws -> [NewsCategory]
    
    /// Fetches the latest news badge containing summary information about all categories
    func fetchLatestNewsBadge() async throws -> LatestNewsBadge
    
    /// Fetches stories for a specific category
    /// - Parameter categoryId: The ID of the category to fetch stories for
    /// - Returns: A response containing the category information and its stories
    func fetchStories(forCategory categoryId: String) async throws -> [Story]
}

public struct KiteNewsAdapter: KiteNewsAdapterProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    public init(urlSession: URLSession = URLSession.shared) {
        session = urlSession
    }
    
    public func fetchLatestCategories() async throws -> [NewsCategory] {
        let path = "/api/batches/latest/categories"
        let response = try await fetch(path, as: CategoryResponse.self)
        return response.categories
    }
    
    public func fetchLatestNewsBadge() async throws -> LatestNewsBadge {
        let path = "/api/batches/latest/badge"
        return try await fetch(path, as: LatestNewsBadge.self)
    }
    
    public func fetchStories(forCategory categoryId: String) async throws -> [Story] {
        let path = "/api/batches/latest/categories/\(categoryId)"
        let response = try await fetch(path, as: CategoryStoriesResponse.self)
        return response.stories
    }
}

extension KiteNewsAdapter {
    private func fetch<T: Decodable>(_ urlPath: String, as type: T.Type) async throws -> T {
        guard let url = URL(string: "https://news.kagi.com\(urlPath)") else {
            fatalError("Bad URL")
        }

        let (data, _) = try await session.data(for: .init(url: url))
        
        let stringResult = String(decoding: data, as: UTF8.self)
        Logger.kite.debug("Fetched data for path \(urlPath): \(stringResult)")
        
        return try decoder.decode(T.self, from: data)
    }
}
