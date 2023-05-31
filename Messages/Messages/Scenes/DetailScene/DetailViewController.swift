//
//  DetailViewController.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    internal var presenter: DetailPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: DetailView {
    
}
