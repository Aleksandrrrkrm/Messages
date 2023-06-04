//
//  DetailVC+Views.swift
//  Messages
//
//  Created by Александр Головин on 03.06.2023.
//

import UIKit

extension DetailViewController {
    
    func setupUI() {
        view.addSubview(baseView)
        baseView.alpha = 0
        view.backgroundColor = UIColor(named: "appDarkBlue")
        setupMessageLabel()
        setupDeleteButton()
        setupImageView()
        setupDateLabel()
    }
    
    func setupBaseLabel(frame: CGRect, data: MessageType?) {
        guard let data else { return }
        let y = frame.origin.y < 200 ? 200 : frame.origin.y
        baseView.layer.cornerRadius = 15
        baseView.clipsToBounds = true
        
        switch data {
        case let .outgoing(text, url, date):
            messageLabel.text = text
            dateLabel.text = format(from: date, to: "dd.MM.YY")
            baseView.backgroundColor(UIColor(named: "appOutgoingMessage") ?? .purple)
            baseView.frame = CGRect(x: frame.origin.x + 50, y: y, width: frame.width - 90, height: frame.height)
            isIncomingMessage = false
            
        case let .incoming(text, url, date):
            dateLabel.text = format(from: date, to: "dd.MM.YY")
            messageLabel.text = text
            baseView.backgroundColor(UIColor(named: "appIncomeMessage") ?? .blue)
            baseView.frame = CGRect(x: frame.origin.x + 40, y: y, width: frame.width - 90, height: frame.height)
            isIncomingMessage = true
        }
    }
    
//    private func configureNavBar() {
//        navigationController?.navigationBar.isHidden = false
//    }
    
    private func setupMessageLabel() {
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
    
    private func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.alpha = 0
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        if isIncomingMessage {
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55).isActive = true
        } else {
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        }
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.bottomAnchor.constraint(equalTo: baseView.centerYAnchor, constant: (baseView.frame.size.height/2)-5)
        ])
        if isIncomingMessage {
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        } else {
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        }
    }
    
    private func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.alpha = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        if isIncomingMessage {
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        } else {
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55).isActive = true
        }
    }
    
    
    //////////
    ///
    ///
    func format(from date: Date, to mask: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mask
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    ///
    ///////
}
