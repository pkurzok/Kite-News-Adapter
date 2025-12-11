//
//  LatestNewsBadge.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

public struct LatestNewsBadge: Decodable {
    public let batchId: String
    public let createdAt: String
    public let hasOnThisDay: Bool
    public let totalStories: Int
    public let totalReadCount: Int
    public let categories: [BadgeCategory]

    public struct BadgeCategory: Decodable {
        public let categoryId: String
        public let categoryName: String
        public let sourceLanguage: String
        public let readCount: Int
        public let clusterCount: Int
    }
}
