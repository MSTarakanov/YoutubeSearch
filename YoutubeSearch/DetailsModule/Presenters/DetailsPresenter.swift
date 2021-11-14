//
//  File.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func updateUI()
    func failure(errorMessage: String)
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol,
         videoModel: VideoModel,
         networkService: NetworkYoutubeManagerProtocol,
         imageLoader: ImageLoader,
         persistanceService: PersistanceManagerProtocol)
    
    var videoModel: VideoModel { get set }
    
    func getVideoWithDetails()
    func getImage(from path: String) -> UIImage?
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    
    let networkService: NetworkYoutubeManagerProtocol
    let persistanceService: PersistanceManagerProtocol
    let imageLoader: ImageLoader
    
    var videoModel: VideoModel
    
    required init(view: DetailsViewProtocol,
                  videoModel: VideoModel,
                  networkService: NetworkYoutubeManagerProtocol,
                  imageLoader: ImageLoader,
                  persistanceService: PersistanceManagerProtocol) {
        self.view = view
        self.videoModel = videoModel
        self.networkService = networkService
        self.persistanceService = persistanceService
        self.imageLoader = imageLoader
        
        // TODO: get details from CD
        
    }
    
    func getVideoWithDetails() {
        networkService.getVideoDetails(by: videoModel.videoID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videoResponseModel):
                    if let videoResponseModel = videoResponseModel {
                        self?.videoModel.details = self?.updateVideodetails(with: videoResponseModel, oldVideoDetails: (self?.videoModel.details))
                        self?.view?.updateUI()
                    }
                case .failure(let error):
                    self?.view?.failure(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func getImage(from path: String) -> UIImage? {
        imageLoader.loadImage(from: path)
    }
    
    // MARK: Helpers functions
    private func updateVideodetails(with videoResponseModel: VideoResponseModel, oldVideoDetails: DetailsModel?) -> DetailsModel? {
        guard let videoItem = videoResponseModel.items?.first else {
            return oldVideoDetails
        }
        let detailsModel = DetailsModel(viewsCount: Int(videoItem.statistics?.viewCount ?? ""),
                                        likesCount: Int(videoItem.statistics?.likeCount ?? ""),
                                        dislikesCount: Int(videoItem.statistics?.dislikeCount ?? ""),
                                        subsCount: oldVideoDetails?.subsCount,
                                        channelImageUrl: oldVideoDetails?.channelImageUrl)
        return detailsModel
    }
}
