//
//  LabelExt.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension UILabel {
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func setManyLines() -> Self {
        self.numberOfLines = 0
        return self
    }
    
    @discardableResult
    func corner(radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func color(textColor color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func color(backgraundColor: UIColor) -> Self {
        self.backgroundColor = backgraundColor
        return self
    }
    
    @discardableResult
    func alignment(_ newTextalignment: NSTextAlignment) -> Self {
        self.textAlignment = newTextalignment
        return self
    }
}
