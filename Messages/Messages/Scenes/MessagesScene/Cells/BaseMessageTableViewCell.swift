//
//  BaseMessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

class BaseMessageTableViewCell: UITableViewCell {
    
    var profileImageView = UIImageView()
    
    var activity = UIActivityIndicatorView(style: .medium)

    var baseView = UIView()
        .backgroundColor(UIColor(named: Colors.appDarkBlue.rawValue) ?? .gray)
    
    var messageLabel = UILabel()
        .color(textColor: .white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 16) ?? UIFont())
        .corner(radius: 10)
    
    func setupContentView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(named: Colors.appDarkBlue.rawValue)
    }
    
    func setupActivity() {
        profileImageView.addSubview(activity)
        activity.startAnimating()
    }
    
    func setData(_ text: String, url: String) {
        messageLabel.text = text
        if let url = URL(string: url) {
            ImageLoader.loadImageWithUrl(url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                    self?.activity.stopAnimating()
                }
            }
        }
    }
    
    func setupLabel() {
        profileImageView.backgroundColor = .white
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15

        baseView.addSubview(messageLabel)
        messageLabel.backgroundColor = .clear
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10),
            messageLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5),
            messageLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5),
            messageLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10)
        ])
    }
}
