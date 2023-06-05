//
//  TableViewExt.swift
//  Messages
//
//  Created by Александр Головин on 05.06.2023.
//

import UIKit

extension UITableView {
    
    @discardableResult
    func hideSeparator() -> Self {
        self.separatorStyle = .none
        return self
    }
    
    @discardableResult
    func scrollsToPop(_ bool: Bool) -> Self {
        self.scrollsToTop = bool
        return self
    }
}
