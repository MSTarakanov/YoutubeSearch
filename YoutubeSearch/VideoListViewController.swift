//
//  VideoListViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 10.11.2021.
//

import UIKit

class VideoListViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_big")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        addConstraints()
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
        ])
    
    }
}
