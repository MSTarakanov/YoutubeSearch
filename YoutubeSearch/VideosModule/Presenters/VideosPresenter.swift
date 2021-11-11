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
}
