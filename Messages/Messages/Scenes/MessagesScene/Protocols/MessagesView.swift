//
//  MessagesView.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

protocol MessagesView: BaseView {
    
    func reloadTableView(_ indexPaths: [IndexPath])
    
    func showInternetAlert()
    
    func showErrorAlert(message: String)
}
