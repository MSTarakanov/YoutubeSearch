//
//  ModuleBuilder.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

protocol Builder {
    static func buildVideosModule() -> UIViewController
    static func buildDetailsModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func buildVideosModule() -> UIViewController {
        let view = VideosViewController()
        let networkService = NetworkYoutubeManager()
        let persistanceService = CoreDataManager.shared
        let presenter = VideosPresenter(view: view, networkService: networkService, persistanceService: persistanceService)
        view.presenter = presenter
        return view
    }
    
    static func buildDetailsModule() -> UIViewController {
        let view = DetailsViewController()
        let networkService = NetworkYoutubeManager()
        let persistanceService = CoreDataManager.shared
        let presenter = DetailsPresenter(view: view, networkService: networkService, persistanceService: persistanceService)
        view.presenter = presenter
        return view
    }
}
