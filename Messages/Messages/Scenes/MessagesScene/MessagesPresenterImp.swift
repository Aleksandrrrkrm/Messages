//
//  MessagesPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

enum MessageType {
    case incoming(String, String, Date)
    case outgoing(String, String, Date)
}

class MessagesPresenterImp: MessagesPresenter {
    
    private weak var view: MessagesView?
    private let router: MessagesRouter
    private let coreDataGateway: CoreDataGateway
    
    private var allMessages: [MessageType] = []
    private var countOfMessage = 0
    private var currentPage = 0
    var isLoading = false
    
    init(_ view: MessagesView,
         _ router: MessagesRouter,
         _ coreDataGetaway: CoreDataGateway) {
        self.view = view
        self.router = router
        self.coreDataGateway = coreDataGetaway
    }
    
    private func getMessages(page: Int) {
        isLoading = true
        RequestManager.request(requestType: .getMessages(offset: page)) { [weak self] (result: Result<MessageData, Error>) in
            switch result {
            case let .success(data):
                self?.currentPage += 20
                self?.countOfMessage = data.result.count
                data.result.forEach {
                    self?.allMessages.append(MessageType.incoming($0,
                                                                  "https://catherineasquithgallery.com/uploads/posts/2023-02/1676653701_catherineasquithgallery-com-p-yabloki-fon-zelenie-212.jpg", Date()))
                }
                self?.reloadTableView()
                self?.isLoading = false
            case let .failure(error):
                self?.isLoading = false
                if let stringError = error as? StringError {
                    let errorMessage = stringError.message
                    self?.view?.showErrorAlert(message: errorMessage)
                } else {
                    self?.view?.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadData() {
        currentPage = 0
        allMessages.removeAll()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        if let data = self.coreDataGateway.getData(sortDescriptors: [sortDescriptor]) {
            data.forEach {
                switch $0 {
                case let .outgoing(text, _, date):
                    self.allMessages.insert(MessageType.outgoing(text,
                                                                 "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg",
                                                                 date), at: 0)
                    
                case .incoming:
                    break
                }
            }
        }
        getMessages(page: currentPage)
    }
    
    private func reloadTableView() {
        if countOfMessage != 0 {
            var newIndexPaths: [IndexPath] = []
            let startIndex = allMessages.count - countOfMessage
            let endIndex = allMessages.count - 1
            for index in startIndex...endIndex {
                let indexPath = IndexPath(row: index, section: 0)
                newIndexPaths.append(indexPath)
            }
            view?.reloadTableView(newIndexPaths)
        }
    }
    
    func sendNewMessage(_ text: String) {
        coreDataGateway.deleteAllData()
        coreDataGateway.saveData(OutgoingMessageModel(text: text, date: Date()), completion: nil)
        allMessages.insert(MessageType.outgoing(text, "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg", Date()), at: 0)
        let newIndexPath = IndexPath(row: 0, section: 0)
        view?.reloadTableView([newIndexPath])
    }
    
    func getData() -> [MessageType] {
        self.allMessages
    }
    
    func loadNextPage() {
        getMessages(page: currentPage)
    }
    
    @objc func appWillEnterForeground() {
        if InternetConnection.checkInternetConnection() {
        } else {
            view?.showInternetAlert()
        }
    }
    
    func openDetailScene(frame: CGRect, data: MessageType?) {
        router.openSomeScene(frame: frame, data: data)
    }
}
