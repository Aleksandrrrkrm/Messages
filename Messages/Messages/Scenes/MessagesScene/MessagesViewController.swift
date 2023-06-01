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
        presenter?.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let chatHeight = tfContentView.bounds.height / 2.5
            let offsetY = keyboardSize.height - chatHeight// - (screenHeight - chatHeight)
            if offsetY > 0 {
                //                UIView.animate(withDuration: 3) {
                self.view.frame.origin.y = -offsetY
                //                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        //        UIView.animate(withDuration: 1) {
        self.view.frame.origin.y = 0
        //        }
    }
}

extension MessagesViewController: MessagesView {
    
    func reloadTableView() {
        performInMainThread {
//            self.tableView.beginUpdates()
//
//            let indexPathsToInsert =  IndexPath(row: presenter?.getData().count ?? 0, section: 0)
//
//            self.tableView.insertRows(at: indexPathsToInsert, with: .automatic)
//
//
//            self.tableView.endUpdates()
                        self.tableView.reloadData()
        }
    }
}
