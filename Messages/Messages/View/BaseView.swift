//
//  BaseView.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

protocol BaseView: AnyObject {}

extension BaseView {
    
    func performInMainThread(_ block: @escaping () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}

extension BaseView where Self: UIViewController {
    
    func showAlert(withTitle title: String,
                   message: String,
                   actionTitle: String?,
                   settingsHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actionTitle {
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                settingsHandler?()
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: Strings.cancel.rawValue, style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
