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
        let model = [VideoModel]()
        let view = VideosViewController()
        let presenter = VideosPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
