//
//  BaseMessageTableViewCell.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import UIKit

class BaseMessageTableViewCell: UITableViewCell {
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    var profileImageView = UIImageView()

    var baseView = UIView()
        .backgroundColor(UIColor(named: "appDarkBlue") ?? .gray)
    
    var messageLabel = UIMessageLabel()
        .color(textColor: .white)
        .setManyLines()
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 16) ?? UIFont())
        .corner(radius: 10)
    
    func setupContentView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(named: "appDarkBlue")
    }
    
    func setMessage(_ text: String) {
        messageLabel.text = text
    }
    
    func setupLabel() {
        
        profileImageView.backgroundColor = .white
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15
        
        baseView.addSubview(messageLabel)
        messageLabel.backgroundColor = .clear
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10),
            messageLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5),
            messageLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5),
            messageLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10)
        ])
    }
    
//    func getImage(_ url: URL) {
//        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
//
//        }
//    }
//
//    func loadImageWithUrl(_ url: URL) {
//
//        var imageURL: URL?
//
//        imageURL = url
//
//
//        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
//
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//
//            if error != nil {
//#if DEBUG
//                print(error as Any)
//#endif
//                return
//            }
//
//            DispatchQueue.main.async(execute: {
//
//                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
//                    if self.imageURL == url {
//                        self.image = imageToCache
//                    }
//                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
//                }
//            })
//        }).resume()
//    }
}
