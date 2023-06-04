//
//  DetailPresenter.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

protocol DetailPresenter {
    
    func getMessageType() -> MessageType?
    
    func deleteAndBack()
}
