//
//  ChannelResponseModel.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import Foundation

// MARK: - ChannelResponseModel
struct ChannelResponseModel: Codable {
    let kind, etag: String?
    let pageInfo: PageInfo?
    let items: [ChannelItem]?
}

// MARK: - Item
struct ChannelItem: Codable {
    let kind, etag, id: String?
    let snippet: ChannelSnippet?
    let contentDetails: ChannelContentDetails?
    let statistics: ChannelStatistics?
}

// MARK: - ContentDetails
struct ChannelContentDetails: Codable {
    let relatedPlaylists: RelatedPlaylists?
}

// MARK: - RelatedPlaylists
struct RelatedPlaylists: Codable {
    let likes, uploads: String?
}

// MARK: - Snippet
struct ChannelSnippet: Codable {
    let title, snippetDescription, customURL: String?
    let publishedAt: String?
    let thumbnails: Thumbnails?
    let localized: Localized?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case title
        case snippetDescription = "description"
        case customURL = "customUrl"
        case publishedAt, thumbnails, localized, country
    }
}

// MARK: - Localized
struct Localized: Codable {
    let title, localizedDescription: String?

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription = "description"
    }
}

// MARK: - Statistics
struct ChannelStatistics: Codable {
    let viewCount, subscriberCount: String?
    let hiddenSubscriberCount: Bool?
    let videoCount: String?
}

