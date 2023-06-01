//
//  MessagesPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

enum MessageType {
    case incoming(String)
    case outgoing(String)
}

class MessagesPresenterImp: MessagesPresenter {
    
    private weak var view: MessagesView?
    private let router: MessagesRouter
    private let coreDataGateway: CoreDataGateway
    
    private var messages: [MessageType] = []
    private var currentPage = 0
    
    init(_ view: MessagesView,
         _ router: MessagesRouter,
         _ coreDataGetaway: CoreDataGateway) {
        self.view = view
        self.router = router
        self.coreDataGateway = coreDataGetaway
    }
    
    private func getMessages(page: Int) {
        RequestManager.request(requestType: .getMessages(offset: page)) { [weak self] (result: Result<MessageData, Error>) in
            switch result {
            case let .success(data):
                self?.currentPage += 20
                data.result.forEach { self?.messages.append(MessageType.incoming($0)) }
                self?.view?.reloadTableView()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadData() {
        currentPage = 0
        messages.removeAll()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        if let data = self.coreDataGateway.getData(sortDescriptors: [sortDescriptor]) {
            data.forEach {
                self.messages.insert(MessageType.outgoing($0), at: 0)
            }
        }
        getMessages(page: currentPage)
    }
    
    func sendNewMessage(_ text: String) {
//        coreDataGateway.deleteAllData()
        coreDataGateway.saveData(OutgoingMessageModel(text: text, date: Date()), completion: nil)
        messages.insert(MessageType.outgoing(text), at: 0)
        view?.reloadTableView()
        print(messages.count)
    }
    
    func getData() -> [MessageType] {
        self.messages
    }
    
    func loadNextPage() {
        getMessages(page: currentPage)
    }
}
