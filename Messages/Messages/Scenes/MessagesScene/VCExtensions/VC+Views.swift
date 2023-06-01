//
//  VC+Views.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension MessagesViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "appDarkBlue")
        configureNavBar()
        setupTextFieldContentView()
        setupTextField()
        setupTableView()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTextFieldContentView () {
        view.addSubview(tfContentView)
        tfContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tfContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tfContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tfContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tfContentView.heightAnchor.constraint(equalToConstant: view.bounds.height / 10)
        ])
    }
    
    private func setupTextField() {
        tfContentView.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: tfContentView.leadingAnchor,
                                           constant: 10),
            textField.trailingAnchor.constraint(equalTo: tfContentView.trailingAnchor,
                                           constant: -10),
            textField.topAnchor.constraint(equalTo: tfContentView.topAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: tfContentView.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "appDarkBlue")
        tableView.scrollsToTop = false
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(OutgoingMessageTableViewCell.self, forCellReuseIdentifier: "outgoingCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tfContentView.topAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
