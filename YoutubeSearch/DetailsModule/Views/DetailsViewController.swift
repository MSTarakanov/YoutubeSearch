//
//  DetailsViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit
import youtube_ios_player_helper

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol!
    
    // MARK: UI privates -
    
    private let playerView: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    private let previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // TODO: subclasses of uiview/uilabel and delete text
    private let videoTitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 17)
        label.textColor = Constants.UI.Colors.shapes
        label.numberOfLines = 2
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 15)
        label.textColor = Constants.UI.Colors.secondaryShapes
        label.isHidden = true
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
        imageView.image = UIImage(named: Constants.UI.ImagesNames.profilePlaceholder)
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
        label.textAlignment = .right
        label.isHidden = true
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
        button.addTarget(self, action: #selector(watchDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: StackViews -
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 24
        return mainStackView
    }()
    
    private let labelsStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        labelsStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        return labelsStackView
    }()
    
    private let likesDislikesStackView: UIStackView = {
        let likesDislikesStackView = UIStackView()
        likesDislikesStackView.translatesAutoresizingMaskIntoConstraints = false
        likesDislikesStackView.axis = .horizontal
        likesDislikesStackView.distribution = .fillEqually
        return likesDislikesStackView
    }()
    
    private let likesStackView: UIStackView = {
        let likesStackView = UIStackView()
        likesStackView.translatesAutoresizingMaskIntoConstraints = false
        likesStackView.axis = .vertical
        likesStackView.alignment = .center
        likesStackView.isHidden = true
        return likesStackView
    }()
    
    private let dislikesStackView: UIStackView = {
        let dislikesStackView = UIStackView()
        dislikesStackView.translatesAutoresizingMaskIntoConstraints = false
        dislikesStackView.axis = .vertical
        dislikesStackView.alignment = .center
        dislikesStackView.isHidden = true
        return dislikesStackView
    }()
    
    private let channelPreviewStackView: UIStackView = {
        let channelPreviewStackView = UIStackView()
        channelPreviewStackView.translatesAutoresizingMaskIntoConstraints = false
        channelPreviewStackView.axis = .horizontal
        channelPreviewStackView.spacing = 8
        return channelPreviewStackView
    }()
    
    private let channelStackView: UIStackView = {
        let channelStackView = UIStackView()
        channelStackView.translatesAutoresizingMaskIntoConstraints = false
        channelStackView.axis = .horizontal
        channelStackView.distribution = .fillEqually
        channelStackView.isLayoutMarginsRelativeArrangement = true
        channelStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        return channelStackView
    }()
    
    // MARK: VC Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.UI.Colors.primary

        videoTitleLable.text = presenter.videoModel.title
        channelTitleLabel.text = presenter.videoModel.channelTitle
        
        presenter.getVideoWithDetails()
        
        addSubviews()
        addConstraints()
        
        playerView.load(withVideoId: presenter.videoModel.videoID)
    }
    
    // MARK: UI setup helpers functions -
    private func addSubviews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(previewView)
        previewView.addSubview(playerView)
        
        labelsStackView.addArrangedSubview(videoTitleLable)
        labelsStackView.addArrangedSubview(viewsCountLabel)
        mainStackView.addArrangedSubview(labelsStackView)
        
        likesStackView.addArrangedSubview(likesImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        dislikesStackView.addArrangedSubview(dislikesImageView)
        dislikesStackView.addArrangedSubview(dislikesCountLabel)
        likesDislikesStackView.addArrangedSubview(likesStackView)
        likesDislikesStackView.addArrangedSubview(dislikesStackView)
        mainStackView.addArrangedSubview(likesDislikesStackView)
        
        channelPreviewStackView.addArrangedSubview(channelImageView)
        channelPreviewStackView.addArrangedSubview(channelTitleLabel)
        channelStackView.addArrangedSubview(channelPreviewStackView)
        channelStackView.addArrangedSubview(subsCountLabel)
        mainStackView.addArrangedSubview(channelStackView)
        
        mainStackView.addArrangedSubview(watchOnYoutubeButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            labelsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            likesImageView.widthAnchor.constraint(equalTo: likesImageView.heightAnchor),
            likesImageView.widthAnchor.constraint(equalToConstant: 65),
            dislikesImageView.widthAnchor.constraint(equalTo: dislikesImageView.heightAnchor),
            dislikesImageView.widthAnchor.constraint(equalToConstant: 65),
            likesDislikesStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            channelImageView.widthAnchor.constraint(equalToConstant: 44),
            channelImageView.heightAnchor.constraint(equalTo: channelImageView.widthAnchor),
            channelStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            
            previewView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            previewView.heightAnchor.constraint(equalTo: previewView.widthAnchor, multiplier: 9/16),
            
            playerView.topAnchor.constraint(equalTo: previewView.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor),
            playerView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
            playerView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
        ])
    }
    
    // MARK: Actions
    @objc
    func watchDidTap() {
        presenter.watchVideo()
    }

}

// MARK: DetailsViewProtocol extension -
extension DetailsViewController: DetailsViewProtocol {
    func updateUI() {
        // TODO: could be simpler
        if let likesCount = presenter.videoModel.details?.likesCount {
            likesCountLabel.text = "\(likesCount)"
        }
        if let dislikesCount = presenter.videoModel.details?.dislikesCount {
            dislikesCountLabel.text = "\(dislikesCount)"
        }
        if let viewsCount = presenter.videoModel.details?.viewsCount {
            viewsCountLabel.text = viewsCount.formattedWithSeparator + " views"
        }
        if let subsCount = presenter.videoModel.details?.subsCount {
            subsCountLabel.text = subsCount.roundedWithAbbreviations + " subscribers"
        }
        if let channelImageUrl = presenter.videoModel.details?.channelImageUrl {            channelImageView.image = presenter.getImage(from: channelImageUrl)
            channelImageView.layer.cornerRadius = channelImageView.frame.width / 2
            channelImageView.clipsToBounds = true
        }
        // TODO: weak self in animate? or not?
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.likesStackView.isHidden = self?.likesCountLabel.text == nil
            self?.dislikesStackView.isHidden = self?.dislikesCountLabel.text == nil
            self?.viewsCountLabel.isHidden = self?.viewsCountLabel.text == nil
            self?.subsCountLabel.isHidden = self?.subsCountLabel.text == nil
            self?.mainStackView.layoutIfNeeded()
        }
    }
    
    func failure(errorMessage: String) {
        self.alert(message: errorMessage)
    }
}
