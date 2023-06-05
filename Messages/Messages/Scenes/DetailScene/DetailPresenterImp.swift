//
//  DetailPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

class DetailPresenterImp: DetailPresenter {
    
    private weak var view: DetailView?
    
    // MARK: - Properties
    var currentMessageData: MessageModel?
    var currentMessageIndex: Int?
    var completion: (_ index: Int) -> ()
    
    // MARK: - Init
    init(_ view: DetailView,
         completion: @escaping (_ index: Int) -> ()) {
        self.view = view
        self.completion = completion
    }
    
    // MARK: - Protocol methods
    func getMessageType() -> MessageModel? {
        currentMessageData
    }
    
    func getData() {
        guard let currentMessageData else { return }
        view?.configureUI(type: currentMessageData)
        showImage(from: currentMessageData.url)
    }
    
    func deleteAndBack() {
        completion(currentMessageIndex ?? 0)
    }
    
    func formatDate(from date: Date, to mask: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mask
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    // MARK: - Private methods
    private func showImage(from url: String) {
        guard let url = URL(string: url) else { return }
        ImageLoader.loadImageWithUrl(url) { [weak self] image in
            guard let image else { return }
            self?.view?.setImage(image)
        }
    }
}
