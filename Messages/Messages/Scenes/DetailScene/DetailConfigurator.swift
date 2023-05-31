//
//  DetailConfigurator.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

enum DetailConfigurator {
    
    static func configure(view: DetailViewController) {
        let presenter = DetailPresenterImp(view)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = DetailViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
