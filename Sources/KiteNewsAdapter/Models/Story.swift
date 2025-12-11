//
//  Story.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

public struct Story: Decodable {
    public let id: String
    public let storyId: String
    public let title: String
    public let url: String
    public let timestamp: Int
    public let domain: String
    public let readCount: Int
    public let thumbnail: String?
    public let summary: String?
    public let isPaywalled: Bool
    public let aiSummary: String?
}

struct CategoryStoriesResponse: Decodable {
    let categoryId: String
    let categoryName: String
    let sourceLanguage: String
    let timestamp: Int
    let stories: [Story]
}
