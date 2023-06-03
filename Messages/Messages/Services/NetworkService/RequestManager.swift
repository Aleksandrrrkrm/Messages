//
//  RequestManager.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

struct StringError: Error {
    let message: String
}

struct RequestManager {
    
    static func request<T: Decodable>(requestType: Request, completion: @escaping (Result<T, Error>) -> Void) {
        
        DispatchQueue.global().async {
            ApiClientImp.shared.execute(requestType: requestType) { (result: Result<Data, Error>) in
                switch result {
                case let .success(str):
                    do {
                        let decoder = JSONDecoder()
                        let suggestionsResponse = try decoder.decode(T.self, from: str)
                        completion(.success(suggestionsResponse))
                    } catch {
#if DEBUG
//                        print("ошибка JSON: \(error)")
#endif
                        if let strData = String(data: str, encoding: .utf8) {
                            completion(.failure(StringError(message: strData)))
                        } else {
                            completion(.failure(error))
                        }
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
