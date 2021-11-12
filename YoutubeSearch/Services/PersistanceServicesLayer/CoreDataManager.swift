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
    
    
    func add(videoModel: VideoModel) {
        
    }
    
    func save(videoModels: [VideoModel]) {
        
    }
    
    func loadVideoModels() -> [VideoModel] {
        guard let videoEntities = try? storeContainer.viewContext.fetch(VideoEntity.fetchRequest()) else {
            return []
        }
        return videoEntities.compactMap {VideoModel(videoEntity: $0)}
    }
    
    
}
