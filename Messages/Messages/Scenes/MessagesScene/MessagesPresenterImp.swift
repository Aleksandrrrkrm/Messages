//
//  MessagesPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

class MessagesPresenterImp: MessagesPresenter {
    
    private weak var view: MessagesView?
    private let router: MessagesRouter
    private var messages: [String] = []
    
    init(_ view: MessagesView,
         _ router: MessagesRouter) {
        self.view = view
        self.router = router
    }
    
    func getMessages() {
        RequestManager.request(requestType: .getMessages(offset: 0)) { [weak self] (result: Result<MessageData, Error>) in
            switch result {
            case let .success(data):
                print(data.result.count)
                data.result.forEach { self?.messages.append($0) }
                self?.view?.reloadTableView()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getData() -> [String] {
        self.messages
    }
}
