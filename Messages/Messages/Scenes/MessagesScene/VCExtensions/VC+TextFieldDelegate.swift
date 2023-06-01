//
//  VC+TextFieldDelegate.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

extension MessagesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            presenter?.sendNewMessage(textField.text ?? "")
            textField.text = nil
        }
        return true
    }
}
