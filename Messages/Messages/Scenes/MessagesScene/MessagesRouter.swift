//
//  MessagesRouter.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class MessagesRouter {
    
    weak var view: UIViewController?
    
    init(_ view: MessagesViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}
