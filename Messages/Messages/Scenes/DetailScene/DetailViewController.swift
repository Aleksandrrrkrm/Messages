//
//  DetailViewController.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    internal var presenter: DetailPresenter?
    
    var baseView = UIView()
    
    var isIncomingMessage = false
    
    var messageLabel = UIMessageLabel()
        .color(textColor: .white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratSemiBold.rawValue, size: 18) ?? UIFont())
        .corner(radius: 10)
        .color(backgraundColor: .clear)
    
    var imageView = UIImageView()
    
    var dateLabel = UILabel()
        .color(textColor: .lightGray)
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 12) ?? UIFont())
        .color(backgraundColor: .clear)
    
    var deleteButton = UIButton(type: .system)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.baseView.alpha = 1
            self?.imageView.alpha = 1
            self?.deleteButton.alpha = 1
            self?.dateLabel.alpha = 1
        }
    }
}

extension DetailViewController: DetailView {
    
}
