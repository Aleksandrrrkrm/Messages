//
//  OutgoingMessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

final class OutgoingMessageTableViewCell: BaseMessageTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupLabel()
        setupProfileImageView()
        setupBaseLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBaseLabel() {
        contentView.addSubview(baseView)
        baseView.backgroundColor = UIColor(named: Colors.appOutgoingMessage.rawValue)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -5),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            baseView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -80)
        ])
    }
    
    func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

