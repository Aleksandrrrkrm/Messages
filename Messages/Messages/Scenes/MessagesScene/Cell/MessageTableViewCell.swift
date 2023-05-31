//
//  MessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var messageLabel = UILabel()
        .setManyLines()
        .font(UIFont(name: Fonts.montserratSemiBold.rawValue, size: 18) ?? UIFont())
        .alignment(.center)
        .corner(radius: 15)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupLabel()
    }
    
    private func setupLabel() {
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setMessage(_ text: String) {
        messageLabel.text = text
    }
}
