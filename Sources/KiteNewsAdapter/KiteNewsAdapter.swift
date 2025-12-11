import Foundation
import OSLog

/// Protocol defining the interface for fetching Kagi News data
public protocol KiteNewsAdapterProtocol {
    /// Fetches the latest available news categories
    /// - Returns: An array of categories containing category metadata including read counts and cluster counts
    /// - Throws: An error if the network request fails or if decoding fails
    func fetchLatestCategories() async throws -> [NewsCategory]
    
    /// Fetches the latest news badge containing summary information about all categories
    /// - Returns: A `NewsBadge` containing metadata about the latest news batch
    /// - Throws: An error if the network request fails or if decoding fails
    func fetchLatestNewsBadge() async throws -> NewsBadge
    
    /// Fetches stories for a specific category within a news batch
    /// - Parameters:
    ///   - badge: The news badge identifying the batch to fetch from
    ///   - category: The category to fetch stories for
    /// - Returns: An array of stories for the specified category
    /// - Throws: An error if the network request fails or if decoding fails
    func fetchStories(forBadge badge: NewsBadge, andCategory category: NewsCategory) async throws -> [Story]
}

public struct KiteNewsAdapter: KiteNewsAdapterProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    /// Creates a new Kite News adapter
    /// - Parameter urlSession: The URL session to use for network requests. Defaults to `URLSession.shared`
    public init(urlSession: URLSession = URLSession.shared) {
        session = urlSession
    }
    
    public func fetchLatestCategories() async throws -> [NewsCategory] {
        let path = "/api/batches/latest/categories"
        let response = try await fetch(path, as: CategoryResponse.self)
        return response.categories
    }
    
    public func fetchLatestNewsBadge() async throws -> NewsBadge {
        let path = "/api/batches/latest"
        return try await fetch(path, as: NewsBadge.self)
    }
    
    public func fetchStories(forBadge badge: NewsBadge, andCategory category: NewsCategory) async throws -> [Story] {
        let path = "/api/batches/\(badge.id)/categories/\(category.id)/stories"
        let response = try await fetch(path, as: CategoryStoriesResponse.self)
        return response.stories
    }
}

extension KiteNewsAdapter {
    /// Fetches data from the Kagi News API and decodes it
    /// - Parameters:
    ///   - urlPath: The API path to fetch from (e.g., "/api/batches/latest")
    ///   - type: The type to decode the response into
    /// - Returns: The decoded response
    /// - Throws: An error if the network request fails or decoding fails
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
