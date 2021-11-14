//
//  VideoModel.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation

struct VideoModel {
    let videoID: String
    let title: String
    let channelTitle: String
    let channelID: String
    let defaultThumbnailsUrl: String
    var details: DetailsModel?
    
    init?(item: SearchItem) {
        guard
            let videoID = item.id?.videoID,
            let title = item.snippet?.title,
            let channelTitle = item.snippet?.channelTitle,
            let defaultThumbnailsUrl = item.snippet?.thumbnails?.thumbnailsDefault?.url,
            let channelID = item.snippet?.channelID
        else {
            return nil
        }
        self.videoID = videoID
        self.title = title
        self.channelTitle = channelTitle
        self.channelID = channelID
        self.defaultThumbnailsUrl = defaultThumbnailsUrl
        self.details = nil
    }
    
    init?(videoEntity: VideoEntity) {
        guard
            let videoID = videoEntity.videoID,
            let title = videoEntity.title,
            let channelTitle = videoEntity.channelTitle,
            let defaultThumbnailsUrl = videoEntity.defaultThumbnailsUrl,
            let channelID = videoEntity.channelID
        else {
            return nil
        }
        self.videoID = videoID
        self.title = title
        self.channelTitle = channelTitle
        self.channelID = channelID
        self.defaultThumbnailsUrl = defaultThumbnailsUrl
        self.details = nil
    }
}

