//
//  MessagesViewController.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

class MessagesViewController: UIViewController {
    
    internal var presenter: MessagesPresenter?
    
    // MARK: - UI elements
    var tableView = UITableView()
    
    var tfContentView = UIView()
        .backgroundColor(UIColor(named: "appMediumBlack") ?? .blue)
        .border(borderWidth: 0.3, borderColor: UIColor(named: "appMediumBlue") ?? .gray)
    
    var textField = UITextField()
        .font(name: Fonts.montserratMedium.rawValue, size: 17)
        .color(textColor: .white)
        .color(backgraundColor: UIColor(named: "appBlack") ?? .blue)
        .placeholder(text: Strings.message.rawValue, .gray)
        .setLeadingPadding(20)
        .corner(radius: 15)
        
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        MessagesConfigurator.configure(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.getMessages()
    }
}

extension MessagesViewController: MessagesView {
    
    func reloadTableView() {
        performInMainThread {
            self.tableView.reloadData()
        }
    }
}
