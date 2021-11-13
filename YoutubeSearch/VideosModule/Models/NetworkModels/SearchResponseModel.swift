//
//  SearchResponseModel.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchResponseModel = try? newJSONDecoder().decode(SearchResponseModel.self, from: jsonData)

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [SearchItem]?
}

// MARK: - Item
struct SearchItem: Codable {
    let kind: ItemKind?
    let etag: String?
    let id: ID?
    let snippet: SearchSnippet?
}

// MARK: - ID
struct ID: Codable {
    let kind: IDKind?
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

enum IDKind: String, Codable {
    case youtubeVideo = "youtube#video"
    case youtubeChannel = "youtube#channel"
}

enum ItemKind: String, Codable {
    case youtubeSearchResult = "youtube#searchResult"
}

// MARK: - Snippet
struct SearchSnippet: Codable {
    let publishedAt: String
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle: String?
    let liveBroadcastContent: LiveBroadcastContent?
    let publishTime: String

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

enum LiveBroadcastContent: String, Codable {
    case none = "none"
    case upcoming = "upcoming"
    case live = "live"
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
