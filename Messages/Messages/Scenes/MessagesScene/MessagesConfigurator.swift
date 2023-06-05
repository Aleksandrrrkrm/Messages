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
        NotificationCenter.default.addObserver(view, selector: #selector(view.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(view, selector: #selector(view.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
