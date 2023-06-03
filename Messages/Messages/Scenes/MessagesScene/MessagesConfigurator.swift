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
        let presenter = MessagesPresenterImp(view,
                                             router,
                                             CoreDataGatewayImp(coreDataStack: CoreStack.shared))
        view.presenter = presenter
        NotificationCenter.default.addObserver(presenter, selector: #selector(presenter.appWillEnterForeground),
                                               name: .appWillEnterForeground, object: nil)
    }
}
