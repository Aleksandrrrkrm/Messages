//
//  VC+Views.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension MessagesViewController {
    
    func setupUI() {
        setupBaseView()
        setupTextFieldContentView()
        setupTextField()
        setupTableView()
        setupTitleView()
    }
    
    private func setupBaseView() {
        view.backgroundColor = UIColor(named: Colors.appDarkBlue.rawValue)
        baseView.backgroundColor = UIColor(named: Colors.appDarkBlue.rawValue)
        view.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            baseView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height / 9) + 1)
        ])
    }
    
    private func setupTextFieldContentView () {
        baseView.addSubview(tfContentView)
        tfContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tfContentView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            tfContentView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            tfContentView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.backgroundView = activityIndicator
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: CellsID.incoming.rawValue)
        tableView.register(OutgoingMessageTableViewCell.self, forCellReuseIdentifier: CellsID.outgoing.rawValue)
        baseView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tfContentView.topAnchor),
            tableView.topAnchor.constraint(equalTo: baseView.topAnchor)
        ])
    }
    
    private func setupTitleView() {
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 9)
        titleLabel.text = Strings.testCase.rawValue
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor)
        ])
    }
}
