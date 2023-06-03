//
//  MessagesPresenter.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

protocol MessagesPresenter {
    
    func loadData()
    
    func getData() -> [MessageType]
    
    func loadNextPage()
    
    func sendNewMessage(_ text: String)
    
    var isLoading: Bool { get }
    
    func openDetailScene(frame: CGRect, data: MessageType?)
}
