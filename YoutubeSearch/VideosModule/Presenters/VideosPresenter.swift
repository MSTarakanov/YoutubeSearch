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
         persistanceService: PersistanceManagerProtocol)
    
    var videoModels: [VideoModel]? {get set}
    func searchVideos(with query: String)
}

class VideosPresenter: VideosPresenterProtocol {
    
    // MARK: MVP setups -
    weak var view: VideosViewProtocol?
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    
    var videoModels: [VideoModel]?
    
    required init(view: VideosViewProtocol,
                  networkService: NetworkYoutubeManagerProtocol,
                  persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.persistanceService = persistanceService
        
        // try to get data from pers
        // mb videosModel! ?
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
    
    // MARK: Private helpers functions -
    private func parseVideoModels(from searchResponseModel: SearchResponseModel) -> [VideoModel] {
        if let searchItems = searchResponseModel.items {
            return searchItems.compactMap {VideoModel(item: $0)}
        }
        print("[DEBUG] no videoModels from searchResponseModel")
        return []
    }
}
