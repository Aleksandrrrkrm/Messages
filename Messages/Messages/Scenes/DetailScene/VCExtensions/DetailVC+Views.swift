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
        setupNavBar()
    }
    
    func setupBaseLabel(frame: CGRect, data: MessageModel?) {
        guard let data else { return }
        let y = frame.origin.y < 200 ? 200 : frame.origin.y
        baseView.layer.cornerRadius = 15
        baseView.clipsToBounds = true
        messageLabel.text = data.text
        dateLabel.text = presenter?.formatDate(from: data.date, to: "dd.MM.YY")
        if data.isMyMessage {
            baseView.backgroundColor(UIColor(named: "appOutgoingMessage") ?? .purple)
            baseView.frame = CGRect(x: frame.origin.x + 40, y: y, width: frame.width - 80, height: frame.height)
            isIncomingMessage = false
            messageLabel.alignment(.right)
        } else {
            baseView.backgroundColor(UIColor(named: "appIncomeMessage") ?? .blue)
            baseView.frame = CGRect(x: frame.origin.x + 40, y: y, width: frame.width - 80, height: frame.height)
            isIncomingMessage = true
            messageLabel.alignment(.left)
        }
    }
    
    private func setupMessageLabel() {
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
    
    private func setupNavBar() {
            if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(named: "appMediumBlack") ?? .purple
            ]
            appearance.backgroundColor = UIColor(named: "appMediumBlack")
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().isTranslucent = false
        } else {
            navigationController?.navigationBar.barTintColor = UIColor(named: "appMediumBlack")
        }
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(named: "appMediumBlack") ?? .purple
            ]
            appearance.backgroundColor = UIColor(named: "appMediumBlack")
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        navigationController?.navigationBar.barTintColor = UIColor(named: "appMediumBlack")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "appMediumBlack")
        navigationController?.navigationBar.isTranslucent = false
    }
}
