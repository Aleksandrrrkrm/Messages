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
    var baseView = UIView()
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let titleView = UIView()
        .backgroundColor(UIColor(named: Colors.appMediumBlack.rawValue) ?? .blue)
    
    let titleLabel = UILabel()
        .alignment(.center)
        .color(textColor: .white)
        .color(backgroundColor: UIColor(named: Colors.appMediumBlack.rawValue) ?? .blue)
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 18) ?? UIFont())
    
    var tableView = UITableView()
        .backgroundColor(UIColor(named: Colors.appDarkBlue.rawValue) ?? .blue)
        .hideSeparator()
        .scrollsToPop(false)
    
    var tfContentView = UIView()
        .backgroundColor(UIColor(named: Colors.appMediumBlack.rawValue) ?? .blue)
        .border(borderWidth: 0.3, borderColor: UIColor(named: Colors.appMediumBlue.rawValue) ?? .gray)
    
    var textField = UITextField()
        .font(name: Fonts.montserratMedium.rawValue, size: 17)
        .color(textColor: .white)
        .color(backgraundColor: UIColor(named: Colors.appBlack.rawValue) ?? .blue)
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        showNavBar()
        hideKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Transition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
         coordinator.animate(alongsideTransition: { context in
             self.titleView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 9)
         })
    }
    
    // MARK: - Usage
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let chatHeight = tfContentView.frame.height / 2.5
            let offsetY = keyboardSize.height - chatHeight
            if offsetY > 0 {
                self.baseView.bounds.origin.y = offsetY

            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        self.baseView.bounds.origin.y = 0
    }
    
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    @objc func handleLongtap(_ gesture: UILongPressGestureRecognizer) {
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
    
    private func showNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Protocol methods
extension MessagesViewController: MessagesView {
    
    func startActivity() {
        performInMainThread { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        performInMainThread { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func showInternetAlert() {
        performInMainThread { [weak self] in
            self?.showAlert(withTitle: Strings.notAvailable.rawValue,
                           message: Strings.checkInternetConnection.rawValue,
                           actionTitle: Strings.settings.rawValue) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        performInMainThread { [weak self] in
            self?.showAlert(withTitle: Strings.errorTitle.rawValue,
                           message: message,
                           actionTitle: Strings.retry.rawValue) {
                self?.presenter?.loadNextPage()
            }
        }
    }
    
    func reloadTableView() {
        performInMainThread { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func deleteRow(_ indexPaths: [IndexPath]) {
        performInMainThread { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: indexPaths, with: .automatic)
            self?.tableView.endUpdates()
        }
    }
    
    func reloadTableView(_ indexPaths: [IndexPath]) {
        performInMainThread { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
            self?.tableView.endUpdates()
        }
    }
}
