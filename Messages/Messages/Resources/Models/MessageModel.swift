//
//  OutgoingMessageModel.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import Foundation

struct MessageModel {
    let isMyMessage: Bool
    let url: String
    let text: String
    let date: Date
}

enum MessageType {
    case incoming(String, String, Date)
    case outgoing(String, String, Date)
}
