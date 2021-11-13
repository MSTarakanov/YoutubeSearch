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
    let defaultThumbnailsUrl: String
    var details: DetailsModel?
    
    init?(item: SearchItem) {
        guard
            let videoID = item.id?.videoID,
            let title = item.snippet?.title,
            let channelTitle = item.snippet?.channelTitle,
            let defaultThumbnailsUrl = item.snippet?.thumbnails?.thumbnailsDefault?.url
        else {
            return nil
        }
        self.videoID = videoID
        self.title = title
        self.channelTitle = channelTitle
        self.defaultThumbnailsUrl = defaultThumbnailsUrl
        self.details = nil
    }
    
    init?(videoEntity: VideoEntity) {
        guard
            let videoID = videoEntity.videoID,
                let title = videoEntity.title,
            let channelTitle = videoEntity.channelTitle,
            let defaultThumbnailsUrl = videoEntity.defaultThumbnailsUrl
        else {
            return nil
        }
        self.videoID = videoID
        self.title = title
        self.channelTitle = channelTitle
        self.defaultThumbnailsUrl = defaultThumbnailsUrl
        self.details = nil
    }
}

