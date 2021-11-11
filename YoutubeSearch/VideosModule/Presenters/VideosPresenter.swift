//
//  VideosPresenter.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

// MARK: Protocols -
protocol VideosViewProtocol: AnyObject {
    func showVideos(_ videos: [Video])
}

protocol VideosPresenterProtocol: AnyObject {
    init(view: VideosViewProtocol, model: [Video])
    
    func searchVideos(with query: String)
}

class VideosPresenter: VideosPresenterProtocol {
    
    // MARK: MVP setups -
    let view: VideosViewProtocol
    let model: [Video]
    
    required init(view: VideosViewProtocol, model: [Video]) {
        self.view = view
        self.model = model
    }
    
    // MARK: Presenter functions -
    func searchVideos(with query: String) {
        
    }
}
