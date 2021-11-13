//
//  DetailsViewController.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
    }

}

extension DetailsViewController: DetailsViewProtocol {
    
}
