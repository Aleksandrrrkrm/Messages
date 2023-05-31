//
//  RequestSettings.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

enum Request {
    
    case getMessages(offset: Int)
}

struct RequestSettings {
    
    static func setupRequest(type: Request) -> URLRequest? {
        
        var request: URLRequest
        
        switch type {
        case let .getMessages(offset: offset):
            let baseURLString = "https://numia.ru/api/getMessages"
            var urlComponents = URLComponents(string: baseURLString)
            urlComponents?.queryItems = [
                    URLQueryItem(name: "offset", value: String(offset))
                ]
                guard let url = urlComponents?.url else {
    #if DEBUG
                    print("ошибка setupRequest getMessages")
    #endif
                    return nil
                }
                request = URLRequest(url: url)
                return request
        }
    }
}
