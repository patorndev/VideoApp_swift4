//
//  SettingCell.swift
//  VideoApp
//
//  Created by Book on 9/12/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    // when the cell is hilighted; change color
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    // set properties of each settingCell
    var setting: Setting? {
        didSet{
            // set label based on setting name
            nameLabel.text = setting?.name.rawValue
            // set icon based on setting imageName
            if let imageName = setting?.imageName {
                // rendering while ignored the color of image
                iconImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                // set default tint color
                iconImage.tintColor = UIColor.darkGray
            }
        }
    }
    
    // create label
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // creat icon
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        // subview
        addSubview(nameLabel)
        addSubview(iconImage)
        
        // horizontal constraint
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImage, nameLabel)
        
        // vertical constraint
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImage)
        
        // center icon image
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
