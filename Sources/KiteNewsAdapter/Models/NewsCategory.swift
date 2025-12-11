//
//  NewsCategory.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

public struct NewsCategory: Decodable, Identifiable, Hashable {
    public let id: String
    public let categoryId: String
    public let categoryName: String
    public let sourceLanguage: String
    public let timestamp: Int
    public let readCount: Int
    public let clusterCount: Int
}

extension NewsCategory {
    
    private static let favoriteCategoriesKey = "favoriteCategoryIds"
    
    public func addToFavorites(userdefaults: UserDefaults = .standard) {
        var favorites = Self.getFavoriteIds(from: userdefaults)
        if !favorites.contains(categoryId) {
            favorites.append(categoryId)
            userdefaults.set(favorites, forKey: Self.favoriteCategoriesKey)
        }
    }
    
    public func removeFromFavorites(userdefaults: UserDefaults = .standard) {
        var favorites = Self.getFavoriteIds(from: userdefaults)
        favorites.removeAll { $0 == categoryId }
        userdefaults.set(favorites, forKey: Self.favoriteCategoriesKey)
    }
    
    private static func getFavoriteIds(from userDefaults: UserDefaults) -> [String] {
        return userDefaults.stringArray(forKey: favoriteCategoriesKey) ?? []
    }
}

extension NewsCategory {
    
    public var isFavorite: Bool {
        let favorites = Self.getFavoriteIds(from: .standard)
        return favorites.contains(categoryId)
    }
}

struct CategoryResponse: Decodable {
    let batchId: String
    let createdAt: String
    let hasOnThisDay: Bool
    let categories: [NewsCategory]
}
