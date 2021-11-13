//
//  DetailsViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol!
    
    // MARK: UI privates
    
    // TODO: subclasses of uiview/uilabel
    private let prewiewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.UI.Colors.secondary
        return view
    }()
    
    private let videoTitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.shapes
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 15)
        label.textColor = Constants.UI.Colors.secondaryShapes
        return label
    }()
    
    private let likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.UI.ImagesNames.likeImage)
        return imageView
    }()
    
    private let dislikesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.UI.ImagesNames.dislikeImage)
        return imageView
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.shapes
        return label
    }()
    
    private let dislikesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.shapes
        return label
    }()
    
    private let channelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = Constants.UI.Colors.secondary
        return imageView
    }()
    
    private let channelTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.shapes
        return label
    }()
    
    private let subsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.secondaryShapes
        return label
    }()
    
    private let watchOnYoutubeButton: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Watch on youtube"
        button.configuration?.baseForegroundColor = Constants.UI.Colors.secondary
        button.configuration?.image = UIImage(systemName: "play")
        button.configuration?.imagePadding = 6
        button.configuration?.imagePlacement = .leading
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
    }

}

extension DetailsViewController: DetailsViewProtocol {
    
}
