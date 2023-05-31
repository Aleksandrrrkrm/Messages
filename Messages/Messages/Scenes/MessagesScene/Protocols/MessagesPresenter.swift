//
//  MessagesPresenter.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

protocol MessagesPresenter {
    
    func getMessages()
    func getData() -> [String]
}
