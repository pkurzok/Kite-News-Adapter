//
//  File.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

public struct NewsCategory: Decodable {
    public let id: String
    public let categoryId: String
    public let categoryName: String
    public let sourceLanguage: String
    public let timestamp: Int
    public let readCount: Int
    public let clusterCount: Int
}

struct CategoryResponse: Decodable {
    let batchId: String
    let createdAt: String
    let hasOnThisDay: Bool
    let categories: [NewsCategory]
}
