//
//  VideoResponseModel.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import Foundation

// MARK: - VideoResponseModel
struct VideoResponseModel: Codable {
    let kind, etag: String?
    let items: [VideoItem]?
    let pageInfo: PageInfo?
}

// MARK: - Item
struct VideoItem: Codable {
    let kind, etag, id: String?
    let snippet: VideoSnippet?
    let contentDetails: VideoContentDetails?
    let statistics: VideoStatistics?
}

// MARK: - ContentDetails
struct VideoContentDetails: Codable {
    let duration, dimension, definition, caption: String?
    let projection: String?
}

// MARK: - Snippet
struct VideoSnippet: Codable {
    let publishedAt: String?
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle: String?
    let tags: [String]?
    let categoryID, liveBroadcastContent, defaultLanguage: String?
    let localized: Localized?
    let defaultAudioLanguage: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, defaultLanguage, localized, defaultAudioLanguage
    }
}

// MARK: - Statistics
struct VideoStatistics: Codable {
    let viewCount, likeCount, dislikeCount, favoriteCount: String?
    let commentCount: String?
}

