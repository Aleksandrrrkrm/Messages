//
//  DetailViewController.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    internal var presenter: DetailPresenter?
    
    // MARK: - UI elements
    var baseView = UIView()
    var imageView = UIImageView()
    var deleteButton = UIButton(type: .system)
    
    var messageLabel = UILabel()
        .color(textColor: .white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 16) ?? UIFont())
        .corner(radius: 10)
        .color(backgroundColor: .clear)
    
    var dateLabel = UILabel()
        .color(textColor: .lightGray)
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 12) ?? UIFont())
        .color(backgroundColor: .clear)
    
    // MARK: - Properties
    var currentMessageFrame: CGRect?
    var isIncomingMessage = false
        
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showViews()
    }
    
    // MARK: - Usage
    private func getData() {
        presenter?.getData()
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

// MARK: - Protocol methods
extension DetailViewController: DetailView {
    
    func setImage(_ image: UIImage) {
        performInMainThread {
            self.imageView.image = image
        }
    }
    
    func configureUI(type: MessageModel) {
        guard let currentMessageFrame else { return }
        setupBaseLabel(frame: currentMessageFrame, data: type)
        setupUI()
    }
}
