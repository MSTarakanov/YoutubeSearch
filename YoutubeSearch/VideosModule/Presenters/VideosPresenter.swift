//
//  VideosPresenter.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

protocol VideosViewProtocol: AnyObject {
    func showVideos(_ videos: [Video])
}

protocol VideosPresenterProtocol: AnyObject {
    init(view: VideosViewProtocol, model: [Video])
    
    func searchVideos(with query: String)
}

class VideosPresenter: VideosPresenterProtocol {
    
    let view: VideosViewProtocol
    let model: [Video]
    
    required init(view: VideosViewProtocol, model: [Video]) {
        self.view = view
        self.model = model
    }
    
    func searchVideos(with query: String) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            var videos = [Video]()
            videos.append(Video(title: "Harry Potter"))
            videos.append(Video(title: "Pop Hover"))
            self?.view.showVideos(videos)
        }
    }
}
