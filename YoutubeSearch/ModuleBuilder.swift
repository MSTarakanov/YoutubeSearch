//
//  ModuleBuilder.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

protocol Builder {
    static func buildVideosModule() -> UIViewController
    static func buildDetailsModule(videoModel: VideoModel) -> UIViewController
}

class ModuleBuilder: Builder {
    static func buildVideosModule() -> UIViewController {
        let view = VideosViewController()
        let networkService = NetworkYoutubeManager()
        let persistanceService = CoreDataManager.shared
        let imageLoader = ImageLoader()
        let presenter = VideosPresenter(view: view, networkService: networkService, imageLoader: imageLoader, persistanceService: persistanceService)
        view.presenter = presenter
        return view
    }
    
    static func buildDetailsModule(videoModel: VideoModel) -> UIViewController {
        let view = DetailsViewController()
        let networkService = NetworkYoutubeManager()
        let persistanceService = CoreDataManager.shared
        let imageLoader = ImageLoader()
        let presenter = DetailsPresenter(view: view, videoModel: videoModel, networkService: networkService, imageLoader: imageLoader, persistanceService: persistanceService)
        view.presenter = presenter
        return view
    }
}
