//
//  DetailPresenter.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

protocol DetailPresenter {
    
    func getMessageType() -> MessageModel?
    
    func deleteAndBack()
    
    func getData()
    
    func formatDate(from date: Date, to mask: String) -> String?
}
