//
//  ImageLoader.swift
//  Messages
//
//  Created by Александр Головин on 05.06.2023.
//

import UIKit

struct ImageLoader {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func loadImageWithUrl(_ url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        
        if let imageFromCache = self.imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
    #if DEBUG
                    print(error as Any)
    #endif
                    completion(nil)
                    return
                }
                
                    if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                        self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                        completion(imageToCache)
                    } else {
                        completion(nil)
                    }
               
            }).resume()
        }
    }
    
}
