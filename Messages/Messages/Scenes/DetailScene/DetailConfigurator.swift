//
//  DetailConfigurator.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

enum DetailConfigurator {
    
    static func configure(view: DetailViewController,
                          frame: CGRect,
                          data: MessageType?) {
        let presenter = DetailPresenterImp(view)
        view.presenter = presenter
        view.setupBaseLabel(frame: frame, data: data)
    }

    static func open(navigationController: UINavigationController,
                     frame: CGRect,
                     data: MessageType?) {
        let view = DetailViewController()
        Self.configure(view: view, frame: frame, data: data)
        navigationController.pushViewController(view, animated: false)
    }
}
