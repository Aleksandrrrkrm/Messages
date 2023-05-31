//
//  MessageModel.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

//   let messageData = try? JSONDecoder().decode(MessageData.self, from: jsonData)

// MARK: - MessageData
struct MessageData: Decodable {
    let result: [String]
}
