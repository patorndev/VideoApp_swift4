//
//  VideoCell.swift
//  VideoApp
//
//  Created by Book on 9/6/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class VideoCell: BaseCell {
    
    
    var video: Video? {
        didSet {
            
            // set video title
            titleLabel.text = video?.title
            
            // set thumbnail image
            setupThumbnailImage()
            // set profile image
            setupProfileimage()
            // set subtitle text
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                // format number method to convert e.g. from 999000999 to 999,000,999
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(formatter.string(from: numberOfViews)!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            // measure title size
            if let title = video?.title {
            
                // whole framwidth - left margin - profile - space - right margin
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                
                // sort of combine fontlead and fragment origin to calculate height
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                // get the estimate Rectangle area size of title text
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleHeightConstraint?.constant = 44
                } else {
                    titleHeightConstraint?.constant = 20
                }

            }
            
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            // call helper method to setup image
//            thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageUrl)
            
            // Kingfisher helper
            let url = URL(string: thumbnailImageUrl)
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(with: url)
        }
    }
    
    func setupProfileimage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            // Kingfisher
            let url = URL(string: profileImageUrl)
            userProfileImageView.kf.setImage(with: url)
        }
    }

    // create big thumbnail
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // create line between each cell
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        // set corner radius to be half the size of userProfileImageView
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,684,607 views - 2 years ago"
        // default inset is 8 change the inset here
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    // modify title constraint
    var titleHeightConstraint: NSLayoutConstraint?
    
    override func setupView() {
        super.setupView()
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        // Horizontal: "H:|-16-[v0]-16-|" 16 left - span everything in the middle - 16 right
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // vertical: top margin + v0 + space btw v0 v1 + v1 + add space for Title and Subtitle + separate line
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        // Horizontal: "H:|[v0]|" span from left edge to right edge
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // titleLable top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // height constraint
        
        titleHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleHeightConstraint!)
        
        // subtitleTextView top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
}
