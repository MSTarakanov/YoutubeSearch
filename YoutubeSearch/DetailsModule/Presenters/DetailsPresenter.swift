//
//  File.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {
    func success()
    func failure(errorMessage: String)
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol,
         videoModel: VideoModel,
         networkService: NetworkYoutubeManagerProtocol,
         persistanceService: PersistanceManagerProtocol)
    
    var videoModel: VideoModel { get set }
    
    func getVideoWithDetails(_ videoID: String)
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    
    var videoModel: VideoModel
    
    required init(view: DetailsViewProtocol, videoModel: VideoModel, networkService: NetworkYoutubeManagerProtocol, persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.videoModel = videoModel
        self.networkService = networkService
        self.persistanceService = persistanceService
    }
    
    func getVideoWithDetails(_ videoID: String) {
        
    }
}
