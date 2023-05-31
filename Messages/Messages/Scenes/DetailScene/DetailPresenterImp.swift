//
//  DetailPresenterImp.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import Foundation

class DetailPresenterImp: DetailPresenter {
    
    private weak var view: DetailView?
    
    init(_ view: DetailView) {
        self.view = view
    }
    
}
