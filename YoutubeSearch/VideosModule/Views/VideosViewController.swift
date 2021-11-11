//
//  VideoListViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 10.11.2021.
//

import UIKit

class VideosViewController: UIViewController {
    
    var presenter: VideosPresenterProtocol!
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.sizeToFit()
        searchBar.placeholder = "Search..."
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    private let videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VideosTableViewCell.nib, forCellReuseIdentifier: VideosTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        videosTableView.addSubview(searchBar)
        
        view.addSubview(videosTableView)
        addNavigationItemImage()
        addConstraints()
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            videosTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videosTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videosTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    
    }
    
    private func addNavigationItemImage() {
        let navImageView = UIImageView()
        navImageView.contentMode = .scaleAspectFit
        navImageView.image = UIImage(named: Constants.UI.ImagesNames.logoWithTextVertical)
        navigationItem.titleView = navImageView
    }
}

extension VideosViewController: VideosViewProtocol {
    func showVideos(_ videos: [Video]) {
        print(videos)
    }
}
