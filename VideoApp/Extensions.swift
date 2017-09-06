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
