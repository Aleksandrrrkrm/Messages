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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.incoming.rawValue,
                                                       for: indexPath) as? MessageTableViewCell,
              let outCell = tableView.dequeueReusableCell(withIdentifier: CellsID.outgoing.rawValue,
                                                          for: indexPath) as? OutgoingMessageTableViewCell
        else {
            return UITableViewCell()
        }
        guard let data = presenter?.getData() else {
            return UITableViewCell()
        }
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        outCell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longtap(_:))))
        outCell.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longtap(_:))))
        
        let currentData = data[indexPath.row]
        
        if data[indexPath.row].isMyMessage {
            outCell.setData(currentData.text, url: currentData.url)
            return outCell
        } else {
            cell.setData(currentData.text, url: currentData.url)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = presenter?.getData().count else { return }
        if indexPath.row == count - 1 && !(presenter?.isLoading ?? false) {
            presenter?.loadNextPage()
        }
    }
}
