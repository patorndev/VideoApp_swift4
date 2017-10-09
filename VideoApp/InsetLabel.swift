//
//  InsetLabel.swift
//  VideoApp
//
//  Created by Book on 9/19/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {
    
    let topInset = CGFloat(10)
    let bottomInset = CGFloat(0)
    let leftInset = CGFloat(0)
    let rightInset = CGFloat(0)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }

}
