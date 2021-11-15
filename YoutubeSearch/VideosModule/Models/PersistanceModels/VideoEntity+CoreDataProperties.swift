//
//  VideoEntity+CoreDataProperties.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 15.11.2021.
//
//

import Foundation
import CoreData


extension VideoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoEntity> {
        return NSFetchRequest<VideoEntity>(entityName: "VideoEntity")
    }

    @NSManaged public var channelID: String?
    @NSManaged public var channelTitle: String?
    @NSManaged public var defaultThumbnailsUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var videoID: String?
    @NSManaged public var createdAt: Date?

}

extension VideoEntity : Identifiable {

}
