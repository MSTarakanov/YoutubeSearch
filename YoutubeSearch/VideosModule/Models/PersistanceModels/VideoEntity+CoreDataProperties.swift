//
//  VideoEntity+CoreDataProperties.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 12.11.2021.
//
//

import Foundation
import CoreData


extension VideoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoEntity> {
        return NSFetchRequest<VideoEntity>(entityName: "VideoEntity")
    }

    @NSManaged public var videoID: String?
    @NSManaged public var title: String?
    @NSManaged public var channelTitle: String?
    @NSManaged public var defaultThumbnailsUrl: String?

}

extension VideoEntity : Identifiable {

}
