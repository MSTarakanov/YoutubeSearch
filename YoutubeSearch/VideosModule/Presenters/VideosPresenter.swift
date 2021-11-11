//
//  VideosPresenter.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

protocol VideosViewProtocol: AnyObject {
    
}

protocol VideosPresenterProtocol: AnyObject {
    init(view: VideosViewProtocol, model: [Video])
}

class VideosPresenter: VideosPresenterProtocol {
    
    let view: VideosViewProtocol
    let model: [Video]
    
    required init(view: VideosViewProtocol, model: [Video]) {
        self.view = view
        self.model = model
    }
    
}
