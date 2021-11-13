//
//  File.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {
    
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol,
         networkService: NetworkYoutubeManagerProtocol,
         persistanceService: PersistanceManagerProtocol)
    
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    
    // var videoInfo: videoModel? videoInfo?
    
    required init(view: DetailsViewProtocol, networkService: NetworkYoutubeManagerProtocol, persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.persistanceService = persistanceService
    }
}
