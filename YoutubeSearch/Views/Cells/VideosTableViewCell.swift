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
    
    @IBOutlet weak var VideoImageView: UIImageView!
    @IBOutlet weak var VideoTitleLabel: UILabel!
    @IBOutlet weak var ChanelTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
