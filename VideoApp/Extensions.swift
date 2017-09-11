//
//  Extensions.swift
//  VideoApp
//
//  Created by Book on 9/6/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

// add convenient RGB method to UIColor
// easier to type color
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// constraint for UIView
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        // create dictionary from UIView range
        var viewDictionary = [String: UIView]()
        // loop through and create key value pair
        // e.g. "v0": thumbnailImageView
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
    
}

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString:String?
    
    func loadImageUsingURLString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                // making sure the cell that is visible is still corresponding to the original imageURL
                if self.imageUrlString == urlString {
                
                    imageCache.object(forKey: urlString as NSString)
                }
                
                self.image = imageToCache
            }
        }).resume()
    }

}
