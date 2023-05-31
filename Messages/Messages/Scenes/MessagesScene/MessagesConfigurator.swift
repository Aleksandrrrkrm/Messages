//
//  MessagesConfigurator.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

enum MessagesConfigurator {
    
    static func configure(view: MessagesViewController) {
        let router = MessagesRouter(view)
        let presenter = MessagesPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = MessagesViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
