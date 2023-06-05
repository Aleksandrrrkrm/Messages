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
    private let coreDataGateway: CoreDataGateway
    
    // MARK: - Properties
    private var allMessages: [MessageModel] = []
    private var countOfMessage = 0
    private var currentPage = 0
    var isLoading = false
    
    // MARK: - Init
    init(_ view: MessagesView,
         _ router: MessagesRouter,
         _ coreDataGetaway: CoreDataGateway) {
        self.view = view
        self.router = router
        self.coreDataGateway = coreDataGetaway
    }
    
    // MARK: - Protocols methods
    func sendNewMessage(_ text: String) {
        let messageDate = Date()
        coreDataGateway.saveData(MessageModel(isMyMessage: true,
                                              url: "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg",
                                              text: text,
                                              date: messageDate),
                                 completion: nil)
        allMessages.insert(MessageModel(isMyMessage: true,
                                        url: "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg",
                                        text: text,
                                        date: messageDate),
                           at: 0)
        let newIndexPath = IndexPath(row: 0, section: 0)
        view?.reloadTableView([newIndexPath])
    }
    
    func getData() -> [MessageModel] {
        self.allMessages
    }
    
    func loadNextPage() {
        getMessages(page: currentPage)
    }
    
    func loadData() {
        currentPage = 0
        allMessages.removeAll()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        if let data = self.coreDataGateway.getData(sortDescriptors: [sortDescriptor]) {
            data.forEach {
                switch $0 {
                case let .outgoing(text, url, date):
                    self.allMessages.insert(MessageModel(isMyMessage: true,
                                                         url: url,
                                                         text: text,
                                                         date: date),
                                            at: 0)
                    
                case .incoming:
                    break
                }
            }
        }
        getMessages(page: currentPage)
    }
    
    func deleteRow(_ index: Int) {
        coreDataGateway.deleteData(withText: allMessages[index].text, at: allMessages[index].date)
        allMessages.remove(at: index)
        view?.reload()
    }
    
    func openDetailScene(frame: CGRect, indexPath: Int) {
        router.openSomeScene(frame: frame,
                             data: allMessages[indexPath],
                             indexPath: indexPath, completion: deleteRow)
    }
    
    @objc func appWillEnterForeground() {
        if !InternetConnection.checkInternetConnection() {
            view?.showInternetAlert()
        }
    }
    
    // MARK: - Private methods
    private func getMessages(page: Int) {
        view?.startActivity()
        isLoading = true
        RequestManager.request(requestType: .getMessages(offset: page)) { [weak self] (result: Result<MessageData, Error>) in
            self?.view?.stopActivity()
            switch result {
            case let .success(data):
                self?.currentPage += 20
                self?.countOfMessage = data.result.count
                data.result.forEach {
                    self?.allMessages.append(MessageModel(isMyMessage: false,
                                                          url: "https://www.perunica.ru/uploads/posts/2019-03/1552932077_1.jpg",
                                                          text: $0,
                                                          date: Date()))
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
}
