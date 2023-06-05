//
//  DetailView.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

protocol DetailView: BaseView {
    
    func configureUI(type: MessageModel)
    
    func setImage(_ image: UIImage)
}
