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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageTableViewCell else {
            return UITableViewCell()
        }
        guard let data = presenter?.getData() else {
            return UITableViewCell()
        }
        print(data[indexPath.row])
        cell.setMessage(data[indexPath.row])
        return cell
    }
}
