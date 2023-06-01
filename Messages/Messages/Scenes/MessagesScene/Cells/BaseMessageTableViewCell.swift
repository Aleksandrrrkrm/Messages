//
//  BaseMessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

class BaseMessageTableViewCell: UITableViewCell {

    var baseView = UIView()
        .backgroundColor(UIColor(named: "appDarkBlue") ?? .gray)
    
    var messageLabel = UIMessageLabel()
        .color(.white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratSemiBold.rawValue, size: 18) ?? UIFont())
        .corner(radius: 10)
    
    func setupContentView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(named: "appDarkBlue")
    }
    
    func setMessage(_ text: String) {
        messageLabel.text = text
    }
    
    func setupLabel() {
        baseView.addSubview(messageLabel)
        messageLabel.backgroundColor = .clear
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -10),
            messageLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -15)
        ])
    }
}
