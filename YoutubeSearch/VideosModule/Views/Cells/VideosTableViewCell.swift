//
//  VideosTableViewCell.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import UIKit

class VideosTableViewCell: UITableViewCell {

    static let identifier = "VideosTableViewCellIdentifier"
    static let nib = UINib(nibName: "VideosTableViewCell", bundle: nil)
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    var presenter: VideosPresenterProtocol!
    
    private var imagePath: String? {
        didSet {
            videoImageView.image = nil
            activityIndicator.startAnimating()
            if let path = imagePath {
                DispatchQueue.global().async { 
                    let image = self.presenter.getImage(from: path)
                    if path == self.imagePath {
                        DispatchQueue.main.async {
                            if let image = image {
                                self.videoImageView.image = image
                            } else {
                                self.videoImageView.image = UIImage(named: Constants.UI.ImagesNames.logo)
                            }
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with videoModel: VideoModel) {
        videoTitleLabel.text = videoModel.title
        channelTitleLabel.text = videoModel.channelTitle
        
        // TODO: load details
        // delegate / singletone / instance of loader / presenter?
        imagePath = videoModel.defaultThumbnailsUrl
    }
}
