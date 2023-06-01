//
//  VC+UITableViewDelegate.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? MessageTableViewCell,
              let outCell = tableView.dequeueReusableCell(withIdentifier: "outgoingCell",
                                                          for: indexPath) as? OutgoingMessageTableViewCell
        else {
            return UITableViewCell()
        }
        guard let data = presenter?.getData() else {
            return UITableViewCell()
        }
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        outCell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        switch data[indexPath.row] {
        case let .outgoing(text):
            outCell.setMessage(text)
            return outCell
        case let .incoming(text):
            cell.setMessage(text)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = presenter?.getData().count else { return }
        if indexPath.row == count - 1 {
            print("efrvervrverv")
            presenter?.loadNextPage()
        }
    }
}
