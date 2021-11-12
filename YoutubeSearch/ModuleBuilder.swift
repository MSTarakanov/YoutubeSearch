//
//  ModuleBuilder.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

protocol Builder {
    static func buildVideosModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func buildVideosModule() -> UIViewController {
        let view = VideosViewController()
        let networkService = NetworkYoutubeManager()
        let coredataManager = CoreDataManager.shared
        let presenter = VideosPresenter(view: view, networkService: networkService, persistanceService: coredataManager)
        view.presenter = presenter
        return view
    }
}
