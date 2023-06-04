//
//  DetailPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

class DetailPresenterImp: DetailPresenter {
    
    private weak var view: DetailView?
    
    var completion: (_ index: Int) -> ()
    
    var currentMessageData: MessageType?
    var currentMessageIndex: Int?
    
    init(_ view: DetailView,
         completion: @escaping (_ index: Int) -> ()) {
        self.view = view
        self.completion = completion
    }
    
    
    func getMessageType() -> MessageType? {
        currentMessageData
    }
    
    func deleteAndBack() {
        completion(currentMessageIndex ?? 0)
    }
}
