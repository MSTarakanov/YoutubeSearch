//
//  CoreDataManager.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 12.11.2021.
//

import Foundation
import CoreData




protocol PersistanceManagerProtocol {
    func save(videoModels: [VideoModel])
    func loadVideoModels() -> [VideoModel]
    func clear()
}

final class CoreDataManager: PersistanceManagerProtocol {

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
    
    
    private func add(videoModel: VideoModel) {
        let videoEntity = VideoEntity(context: storeContainer.viewContext)
        videoEntity.videoID = videoModel.videoID
        videoEntity.title = videoModel.title
        videoEntity.channelTitle = videoModel.channelTitle
        videoEntity.defaultThumbnailsUrl = videoModel.defaultThumbnailsUrl
    }
    
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
    
    func clear() {
        guard let videoEntities = try? storeContainer.viewContext.fetch(VideoEntity.fetchRequest()) else {
            print("[DEBUG] CoreData fetch error")
            return
        }
        for videoEntity in videoEntities {
            storeContainer.viewContext.delete(videoEntity)
        }
    }
}
