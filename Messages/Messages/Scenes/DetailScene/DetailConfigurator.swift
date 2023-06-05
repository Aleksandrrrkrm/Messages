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
                          data: MessageModel?,
                          indexPath: Int,
                          completion: @escaping (_ index: Int) -> ()) {
        let presenter = DetailPresenterImp(view, completion: completion)
        presenter.currentMessageData = data
        presenter.currentMessageIndex = indexPath
        view.presenter = presenter
        view.currentMessageFrame = frame
    }

    static func open(navigationController: UINavigationController,
                     frame: CGRect,
                     data: MessageModel?,
                     indexPath: Int,
                     completion: @escaping (_ index: Int) -> ()) {
        let view = DetailViewController()
        Self.configure(view: view,
                       frame: frame,
                       data: data,
                       indexPath: indexPath,
                       completion: completion)
        navigationController.pushViewController(view, animated: false)
    }
}
