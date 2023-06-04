//
//  DetailViewController.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    internal var presenter: DetailPresenter?
    
    var currentMessageFrame: CGRect?
    
    var baseView = UIView()
    
    var isIncomingMessage = false
    
    var messageLabel = UIMessageLabel()
        .color(textColor: .white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 16) ?? UIFont())
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
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showViews()
    }
    
    private func configureUI() {
        guard let message = presenter?.getMessageType(),
              let currentMessageFrame else { return }
        setupBaseLabel(frame: currentMessageFrame, data: message)
        setupUI()
    }
    
    private func showViews() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.baseView.alpha = 1
            self?.imageView.alpha = 1
            self?.deleteButton.alpha = 1
            self?.dateLabel.alpha = 1
        }
    }
    
    @objc
    func deletePressed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presenter?.deleteAndBack()
            self.navigationController?.popViewController(animated: true)
        }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.baseView.frame.origin.x = self?.view.frame.width ?? 500
            self?.imageView.alpha = 0
            self?.deleteButton.alpha = 0
            self?.dateLabel.alpha = 0
        }
    }
}

extension DetailViewController: DetailView {
    
}
