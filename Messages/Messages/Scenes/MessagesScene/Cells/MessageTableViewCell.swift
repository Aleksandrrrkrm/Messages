//
//  MessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

class MessageTableViewCell: BaseMessageTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupContentView()
        setupLabel()
        setupBaseLabel()
    }
    
    private func setupBaseLabel() {
        contentView.addSubview(baseView)
        baseView.backgroundColor = UIColor(named: "appIncomeMessage")
        baseView.layer.cornerRadius = 15
        baseView.clipsToBounds = true
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            baseView.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width)
        ])
    }
}
