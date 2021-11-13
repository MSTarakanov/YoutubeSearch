//
//  DetailsViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol!
    
    // MARK: UI privates -
    
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
        label.text = "No title for this video"
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .generalMedium(with: 15)
        label.textColor = Constants.UI.Colors.secondaryShapes
        label.text = "No viewscount for this video"
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
    
    // MARK: StackViews -
    
    
    // MARK: VC Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        addSubviews()
        addConstraints()
    }
    
    // MARK: UI setup helpers functions -
    private func addSubviews() {
        // TODO: Reorganize it
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.backgroundColor = .cyan
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(prewiewView)
        
        let labelsStackView = UIStackView()
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        
        labelsStackView.addArrangedSubview(videoTitleLable)
        labelsStackView.addArrangedSubview(viewsCountLabel)
        mainStackView.addArrangedSubview(labelsStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            prewiewView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            prewiewView.heightAnchor.constraint(equalTo: prewiewView.widthAnchor, multiplier: 9/16),
            
            labelsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
        
    }
    
    private func addConstraints() {
        
    }

}


// MARK: DetailsViewProtocol extension -
extension DetailsViewController: DetailsViewProtocol {
    
}
