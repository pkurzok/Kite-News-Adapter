//
//  Story.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import Foundation

// MARK: - Supporting Models

public struct PerspectiveSource: Decodable {
    public let name: String
    public let url: String
}

public struct Perspective: Decodable {
    public let text: String
    public let sources: [PerspectiveSource]
}

public struct StoryImage: Decodable {
    public let url: String
    public let caption: String
    public let credit: String
    public let link: String
}

public struct TimelineEvent: Decodable {
    public let date: String
    public let content: String
}

public struct Article: Decodable {
    public let title: String
    public let link: String
    public let domain: String
    public let date: String
    public let image: String
    public let imageCaption: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case domain
        case date
        case image
        case imageCaption = "image_caption"
    }
}

public struct Domain: Decodable {
    public let name: String
    public let favicon: String
    public let isPaywalled: Bool
}

public struct QnA: Decodable {
    public let question: String
    public let answer: String
}

// MARK: - Story

public struct Story: Decodable {
    public let id: String
    public let clusterNumber: Int
    public let uniqueDomains: Int
    public let numberOfTitles: Int
    public let sourceLanguage: String
    public let category: String
    public let title: String
    public let shortSummary: String
    public let didYouKnow: String?
    public let talkingPoints: [String]
    public let quote: String?
    public let quoteAuthor: String?
    public let quoteAttribution: String?
    public let quoteSourceUrl: String?
    public let quoteSourceDomain: String?
    public let location: String?
    public let perspectives: [Perspective]
    public let emoji: String
    public let historicalBackground: String?
    public let internationalReactions: [String]
    public let timeline: [TimelineEvent]
    public let technicalDetails: [String]
    public let userActionItems: [String]
    public let industryImpact: [String]
    public let suggestedQna: [QnA]
    public let primaryImage: StoryImage?
    public let secondaryImage: StoryImage?
    public let articles: [Article]
    public let domains: [Domain]
    public let selectedLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case clusterNumber = "cluster_number"
        case uniqueDomains = "unique_domains"
        case numberOfTitles = "number_of_titles"
        case sourceLanguage
        case category
        case title
        case shortSummary = "short_summary"
        case didYouKnow = "did_you_know"
        case talkingPoints = "talking_points"
        case quote
        case quoteAuthor = "quote_author"
        case quoteAttribution = "quote_attribution"
        case quoteSourceUrl = "quote_source_url"
        case quoteSourceDomain = "quote_source_domain"
        case location
        case perspectives
        case emoji
        case historicalBackground = "historical_background"
        case internationalReactions = "international_reactions"
        case timeline
        case technicalDetails = "technical_details"
        case userActionItems = "user_action_items"
        case industryImpact = "industry_impact"
        case suggestedQna = "suggested_qna"
        case primaryImage = "primary_image"
        case secondaryImage = "secondary_image"
        case articles
        case domains
        case selectedLanguage
    }
}

// MARK: - Category Stories Response

struct CategoryStoriesResponse: Decodable {
    let batchId: String
    let categoryId: String
    let categoryName: String
    let timestamp: Int
    let stories: [Story]
    let totalStories: String
    let domains: [Domain]
    let readCount: Int
}
