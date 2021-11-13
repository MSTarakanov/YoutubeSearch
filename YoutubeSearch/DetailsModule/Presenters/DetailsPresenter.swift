//
//  File.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func success()
    func failure(errorMessage: String)
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol,
         videoModel: VideoModel,
         networkService: NetworkYoutubeManagerProtocol,
         imageLoader: ImageLoader,
         persistanceService: PersistanceManagerProtocol)
    
    var videoModel: VideoModel { get set }
    
    func getVideoWithDetails(_ videoID: String)
    func getImage(from path: String) -> UIImage?
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    let imageLoader: ImageLoader
    
    var videoModel: VideoModel
    
    required init(view: DetailsViewProtocol,
                  videoModel: VideoModel,
                  networkService: NetworkYoutubeManagerProtocol,
                  imageLoader: ImageLoader,
                  persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.videoModel = videoModel
        self.networkService = networkService
        self.persistanceService = persistanceService
        self.imageLoader = imageLoader
        
        // TODO: get details from CD
        
    }
    
    func getVideoWithDetails(_ videoID: String) {
        
    }
    
    func getImage(from path: String) -> UIImage? {
        imageLoader.loadImage(from: path)
    }
}
