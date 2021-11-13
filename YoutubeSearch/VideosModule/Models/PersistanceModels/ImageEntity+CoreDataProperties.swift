//
//  ImageEntity+CoreDataProperties.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var path: String?
    @NSManaged public var imageData: Data?

}

extension ImageEntity : Identifiable {

}
