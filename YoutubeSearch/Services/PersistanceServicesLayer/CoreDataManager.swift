//
//  CoreDataManager.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 12.11.2021.
//

import CoreData
import UIKit

protocol PersistanceManagerProtocol {
    func save(videoModels: [VideoModel])
    func loadVideoModels() -> [VideoModel]
    func clearVideoModels()
    
    func save(imageModel: ImageModel)
    func getImage(with path: String) -> UIImage?
    func clearImageModels()
}

final class CoreDataManager: PersistanceManagerProtocol {

    // MARK: Setup -
    private let modelName = "Database"
    
    static let shared = CoreDataManager()

    private let storeContainer: NSPersistentContainer
    
    private init() {
        self.storeContainer = NSPersistentContainer(name: modelName)
        // Load store (SQLite object)
        self.storeContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        // CAUTION: Uncomment only for testing
        // self.clearImageModels()
    }
    
    // MARK: Videos functions -
    func save(videoModels: [VideoModel]) {
        storeContainer.performBackgroundTask { context in
            for videoModel in videoModels {
                self.add(videoModel: videoModel, context: context)
            }
            do {
                try context.save()
            } catch {
                print("[DEBUG] Context videos save error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func loadVideoModels() -> [VideoModel] {
        guard let videoEntities = try? storeContainer.viewContext.fetch(VideoEntity.fetchRequest()) else {
            print("[DEBUG] CoreData fetch error")
            return []
        }
        return videoEntities.compactMap {VideoModel(videoEntity: $0)}
    }
    
    func clearVideoModels() {
        storeContainer.performBackgroundTask { context in
            guard let videoEntities = try? context.fetch(VideoEntity.fetchRequest()) else {
                print("[DEBUG] CoreData videoEntity fetch error")
                return
            }
            for videoEntity in videoEntities {
                context.delete(videoEntity)
            }
            do {
                try context.save()
            } catch {
                print("[DEBUG] Context clear videos save error: \(error.localizedDescription)")
            }
        }
    }
    // MARK: Helpers functions -
    private func add(videoModel: VideoModel, context: NSManagedObjectContext) {
        let videoEntity = VideoEntity(context: context)
        videoEntity.videoID = videoModel.videoID
        videoEntity.title = videoModel.title
        videoEntity.channelTitle = videoModel.channelTitle
        videoEntity.defaultThumbnailsUrl = videoModel.defaultThumbnailsUrl
        videoEntity.channelID = videoModel.channelID
    }
    
    // MARK: Images functions -
    func save(imageModel: ImageModel) {
        storeContainer.performBackgroundTask { context in
            let imageEntity = ImageEntity(context: context)
            guard let imageData = imageModel.image.pngData() else {
                print("[DEBUG] No data from image")
                return
            }
            imageEntity.path = imageModel.imagePath
            imageEntity.imageData = imageData
            do {
                try context.save()
            } catch {
                print("[DEBUG] Context save image error: \(error.localizedDescription)")
            }
        }
    }
    
    func getImage(with path: String) -> UIImage? {
        let fetchRequest: NSFetchRequest = ImageEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "path == %@", path)
        guard let imageEntities = try? storeContainer.viewContext.fetch(fetchRequest) else {
            print("[DEBUG] CoreData imageEntity fetch error")
            return nil
        }
        guard imageEntities.count < 2 else {
            print("[DEBUG] Many images by one path in DB")
            return nil
        }
        guard imageEntities.count == 1 else {
            return nil
        }
        guard let imageData = imageEntities.first?.imageData else {
            print("[DEBUG] No data for imageEntity")
            return nil
        }
        guard let image = UIImage(data: imageData) else {
            print("[DEBUG] Bad try to convert data to UIImage")
            return nil
        }
        return image
    }
    
    func clearImageModels() {
        storeContainer.performBackgroundTask { context in
            guard let imageEntities = try? context.fetch(ImageEntity.fetchRequest()) else {
                print("[DEBUG] CoreData imageEntity fetch error")
                return
            }
            for imageEntity in imageEntities {
                context.delete(imageEntity)
            }
            do {
                try context.save()
            } catch {
                print("[DEBUG] Context image clear save error: \(error.localizedDescription)")
            }
        }
        
    }
}
