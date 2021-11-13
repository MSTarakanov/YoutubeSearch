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
    func getImage(with path: String) -> UIImage
    func clearImageModels()
}

final class CoreDataManager: PersistanceManagerProtocol {

    // MARK: Setup -
    private let modelName = "Database"
    
    static let shared = CoreDataManager()

    private let storeContainer: NSPersistentContainer
    
    private init() {
        self.storeContainer = NSPersistentContainer(name: modelName)
    }
    
    // Load store (SQLite object)
    func initCoreData(completion: @escaping () -> Void) {
        storeContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            completion()
        }
    }
    
    // MARK: Videos functions -
    func save(videoModels: [VideoModel]) {
        for videoModel in videoModels {
            add(videoModel: videoModel)
        }
        do {
            try storeContainer.viewContext.save()
        } catch {
            print("[DEBUG] Context save error: \(error.localizedDescription)")
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
        guard let videoEntities = try? storeContainer.viewContext.fetch(VideoEntity.fetchRequest()) else {
            print("[DEBUG] CoreData videoEntity fetch error")
            return
        }
        for videoEntity in videoEntities {
            storeContainer.viewContext.delete(videoEntity)
        }
        do {
            try storeContainer.viewContext.save()
        } catch {
            print("[DEBUG] Context save error: \(error.localizedDescription)")
        }
    }
    // MARK: Helpers functions -
    private func add(videoModel: VideoModel) {
        let videoEntity = VideoEntity(context: storeContainer.viewContext)
        videoEntity.videoID = videoModel.videoID
        videoEntity.title = videoModel.title
        videoEntity.channelTitle = videoModel.channelTitle
        videoEntity.defaultThumbnailsUrl = videoModel.defaultThumbnailsUrl
    }
    
    // MARK: Images functions -
    func save(imageModel: ImageModel) {
        let imageEntity = ImageEntity(context: storeContainer.viewContext)
        imageEntity.path = imageModel.imagePath
        guard let imageData = imageModel.image.pngData() else {
            print("[DEBUG] No data from image")
            return
        }
        imageEntity.imageData = imageData
        do {
            try storeContainer.viewContext.save()
        } catch {
            print("[DEBUG] Context save error: \(error.localizedDescription)")
        }
    }
    
    func getImage(with path: String) -> UIImage {
        <#code#>
    }
    
    func clearImageModels() {
        guard let imageEntities = try? storeContainer.viewContext.fetch(ImageEntity.fetchRequest()) else {
            print("[DEBUG] CoreData imageEntity fetch error")
            return
        }
        for imageEntity in imageEntities {
            storeContainer.viewContext.delete(imageEntity)
        }
        do {
            try storeContainer.viewContext.save()
        } catch {
            print("[DEBUG] Context save error: \(error.localizedDescription)")
        }
    }
}
