//
//  MessageLabel.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

class UIMessageLabel: UILabel {
    public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
