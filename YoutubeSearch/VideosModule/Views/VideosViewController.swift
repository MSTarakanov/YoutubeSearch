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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VideosTableViewCell.nib, forCellReuseIdentifier: VideosTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: ViewController Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
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
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            videosTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
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
        self.alert(message: errorMessage)
    }
}

// MARK: SearchBarDelegate -
extension VideosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("[DEBUG] Search button at keyboard clicked")
        presenter.searchVideos(with: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

// MARK: TableView extensions

extension VideosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.videoModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideosTableViewCell.identifier, for: indexPath) as! VideosTableViewCell
        let videoModel = presenter.videoModels[indexPath.row]
        cell.configureCell(with: videoModel)
        cell.presenter = presenter
        return cell
    }
    
    
}

extension VideosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = ModuleBuilder.buildDetailsModule(videoModel: presenter.videoModels[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
