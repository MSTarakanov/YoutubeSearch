//
//  VideosPresenter.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

// MARK: Protocols -
protocol VideosViewProtocol: AnyObject {
    func success()
    func failure(errorMessage: String)
}

protocol VideosPresenterProtocol: AnyObject {
    init(view: VideosViewProtocol,
         networkService: NetworkYoutubeManagerProtocol,
         imageLoader: ImageLoader,
         persistanceService: PersistanceManagerProtocol)
    
    var videoModels: [VideoModel]! {get set}
    
    func searchVideos(with query: String)
    func getImage(from path: String) -> UIImage?
}

class VideosPresenter: VideosPresenterProtocol {
    
    // MARK: MVP setups -
    weak var view: VideosViewProtocol?
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    let imageLoader: ImageLoader
    
    var videoModels: [VideoModel]! {
        didSet {
            // TODO: check is it right to work with context at back thread
            DispatchQueue.global(qos: .userInitiated).async {
                self.persistanceService.clearImageModels()
                self.persistanceService.clearVideoModels()
                self.persistanceService.save(videoModels: self.videoModels)
            }
        }
    }
    
    required init(view: VideosViewProtocol,
                  networkService: NetworkYoutubeManagerProtocol,
                  imageLoader: ImageLoader,
                  persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.persistanceService = persistanceService
        self.imageLoader = imageLoader
        
        self.videoModels = persistanceService.loadVideoModels()
    }
    
    // MARK: Presenter functions -
    func searchVideos(with query: String) {
        networkService.getVideos(with: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResponseModel):
                    if let searchResponseModel = searchResponseModel {
                        self?.videoModels = self?.parseVideoModels(from: searchResponseModel) ?? []
                    }
                    self?.view?.success()
                case .failure(let error):
                    // TODO: AlertService.Alert
                    print(error.localizedDescription)
                    self?.view?.failure(errorMessage: error.localizedDescription)
                }
            } 
        }
    }
    
    func getImage(from path: String) -> UIImage? {
        imageLoader.loadImage(from: path)
    }
    
    // MARK: Private helpers functions -
    private func parseVideoModels(from searchResponseModel: SearchResponseModel) -> [VideoModel] {
        if let searchItems = searchResponseModel.items {
            return searchItems.compactMap {VideoModel(item: $0)}
        }
        print("[DEBUG] no videoModels from searchResponseModel")
        return []
    }
}
