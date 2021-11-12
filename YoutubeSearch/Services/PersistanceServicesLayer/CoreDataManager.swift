//
//  CoreDataManager.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 12.11.2021.
//

import Foundation

protocol PersistanceManagerProtocol {
    func save(videoModels: [VideoModel])
    func loadVideoModels() -> [VideoModel]
}

class CoreDataManager: PersistanceManagerProtocol {
    func save(videoModels: [VideoModel]) {
        
    }
    
    func loadVideoModels() -> [VideoModel] {
        return []
    }
    
    
}
