//
//  TextFieldExt.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

import UIKit

extension UITextField {
    
    @discardableResult
    func placeholder(text: String, _ color: UIColor? = nil) -> Self {
        if color != nil {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray
            ]
            let attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
            self.attributedPlaceholder = attributedPlaceholder
            return self
        } else {
            self.placeholder = text
            return self
        }
    }
    
    @discardableResult
    func setLeadingPadding(_ padding: CGFloat) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        return self
    }
    
    @discardableResult
    func font(name: String, size: CGFloat) -> Self {
        self.font = UIFont(name: name, size: size)
        return self
    }
    
    @discardableResult
    func corner(radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func color(backgraundColor: UIColor) -> Self {
        self.backgroundColor = backgraundColor
        return self
    }
    
    @discardableResult
    func color(textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
}
