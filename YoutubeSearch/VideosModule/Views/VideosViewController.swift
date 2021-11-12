//
//  VideoListViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 10.11.2021.
//

import UIKit

class VideosViewController: UIViewController {
    
    var presenter: VideosPresenterProtocol!
    
    // MARK: UI privates -
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
        tableView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(VideosTableViewCell.nib, forCellReuseIdentifier: VideosTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: ViewController Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        videosTableView.addSubview(searchBar)
        view.addSubview(videosTableView)
        
        videosTableView.dataSource = self
        videosTableView.delegate = self
        searchBar.delegate = self
        
        addNavigationItemImage()
        addConstraints()
    }
    
    // MARK: Private func helpers -
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

// MARK: VideosViewProtocol -
extension VideosViewController: VideosViewProtocol {
    func success() {
        videosTableView.reloadData()
    }
    
    func failure(errorMessage: String) {
        print(errorMessage)
    }
}

// MARK: SearchBarDelegate -
extension VideosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("[DEBUG] Search button at keyboard clicked")
        presenter.searchVideos(with: searchBar.text ?? "")
    }
}

// MARK: TableView extensions

extension VideosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.videoModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideosTableViewCell.identifier, for: indexPath) as! VideosTableViewCell
        let videoModel = presenter.videoModels?[indexPath.row]
        cell.VideoTitleLabel.text = videoModel?.title
        return cell
    }
    
    
}

extension VideosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
