//
//  NewsBadge.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

public struct NewsBadge: Decodable {
    public let id: String
    public let createdAt: String
    public let totalCategories: Int
    public let totalClusters: Int
    public let totalArticles: Int
    public let totalReadCount: Int
    public let processingTime: Int
    public let languageCode: String
    public let dateSlug: String
}
