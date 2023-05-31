//
//  ViewExt.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension UIView {
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func border(borderWidth: CGFloat, borderColor: UIColor) -> Self {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        return self
    }
}
