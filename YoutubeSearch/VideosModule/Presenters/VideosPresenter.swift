//
//  VideosPresenter.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

// MARK: Protocols -
protocol VideosViewProtocol: AnyObject {
    func showVideos(_ videos: [VideoModel])
}

protocol VideosPresenterProtocol: AnyObject {
    init(view: VideosViewProtocol, model: [VideoModel])
    
    func searchVideos(with query: String)
}

class VideosPresenter: VideosPresenterProtocol {
    
    // MARK: MVP setups -
    let view: VideosViewProtocol
    let model: [VideoModel]
    
    required init(view: VideosViewProtocol, model: [VideoModel]) {
        self.view = view
        self.model = model
    }
    
    // MARK: Presenter functions -
    func searchVideos(with query: String) {
        
    }
    
    // MARK: Private helpers functions -
    private func getVideoModels(from searchResponseModel: SearchResponseModel) -> [VideoModel] {
        if let searchItems = searchResponseModel.items {
            return searchItems.compactMap {VideoModel(item: $0)}
        }
        print("[DEBUG] no videoModels from searchResponseModel")
        return []
    }
}
