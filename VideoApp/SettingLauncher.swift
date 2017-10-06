//
//  SettingLauncher.swift
//  VideoApp
//
//  Created by Book on 9/12/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & Privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}


class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // add black faded blackground
    let blackView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    // add collectionview for slidein menu
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    
    let settings: [Setting] = {
        
        return [Setting(name: .Settings, imageName: "settings"),
                Setting(name: .TermsPrivacy, imageName: "privacy"),
                Setting(name: .SendFeedback, imageName: "feedback"),
                Setting(name: .Help, imageName: "help"),
                Setting(name: .SwitchAccount, imageName: "switch_account"),
                Setting(name: .Cancel, imageName: "cancel")]
    }()
    

    var homeController: HomeController? // optional bc could be nil
    
    
    func showSetting() {
        // get window object
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            // when user tap on blackview area call handleDismiss function
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            // setup frame for slide in menu
            // height is exactly combine height of total cells
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            // setup frame for blackView to the size of entire window
            blackView.frame = window.frame
            blackView.alpha = 0
            
            // setup animation in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                // BlackView fade in
                self.blackView.alpha = 1
                // Setting Menu slide up to the size of its height
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
        
    }
    
    @objc func handleDismiss(setting: Setting) {
        
        // setup animation out
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            // BlackView fade out
            self.blackView.alpha = 0
            
            // Setting Menu slide down
            // Upon completion call for stack view
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            
            // if not nil or Cancle call showControllerForSetting from homecontroller
            if setting.name != .Cancel {
                
                self.homeController?.showControllerForSetting(setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // default spacing between each cell is 10; set it to 0
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let setting = self.settings[indexPath.item]
            // call handleDismiss based on selected item
            handleDismiss(setting: setting)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // instantiate the cell
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
