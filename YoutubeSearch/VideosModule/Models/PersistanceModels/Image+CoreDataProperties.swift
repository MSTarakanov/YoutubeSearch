//
//  Image+CoreDataProperties.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var path: String?
    @NSManaged public var imageData: Data?

}

extension Image : Identifiable {

}
