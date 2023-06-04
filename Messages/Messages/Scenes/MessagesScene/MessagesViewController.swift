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
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
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
        
        hideNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        showNavBar()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func showNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
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
    
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    @objc func longtap(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            if let cell = gesture.view as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    feedbackGenerator.impactOccurred()
                    
                    let cellFrame = tableView.rectForRow(at: indexPath)
                    let cellFrameOnScreen = tableView.convert(cellFrame, to: nil)
                       
                    presenter?.openDetailScene(frame: cellFrameOnScreen, indexPath: indexPath.row)
                }
            }
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        print("Ячейка была зажата в течение 1 секунды")
    }
}

extension MessagesViewController: MessagesView {
    
    func reload() {
        performInMainThread {
            self.tableView.reloadData()
        }
    }
    
    func deleteRow(_ indexPaths: [IndexPath]) {
        performInMainThread {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func reloadTableView(_ indexPaths: [IndexPath]) {
        performInMainThread {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func showInternetAlert() {
        performInMainThread {
            self.showAlert(withTitle: Strings.notAvailable.rawValue,
                           message: Strings.checkInternetConnection.rawValue,
                           actionTitle: Strings.settings.rawValue,
                           viewController: self) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        performInMainThread {
            self.showAlert(withTitle: Strings.errorTitle.rawValue,
                           message: message,
                           actionTitle: "Повторить",
                           viewController: self) {
                self.presenter?.loadNextPage()
            }
        }
    }
    
}
