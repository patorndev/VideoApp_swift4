//
//  Menubar.swift
//  VideoApp
//
//  Created by Book on 9/6/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    let cellId = "cellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?

    // lazy var: because its initial value might not be retrieved until after instance initialization completes
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        setupHorizontalBar()
    }
    
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        // oldschool frame way of doing thing
        //horizontalBarView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        // newschool in ios9 +
        // need x, y, width, height constraints
        
        //x
            
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        //y
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // width
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4).isActive = true
        // height
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print(indexPath)
//        // get the starting point of the horizontal bar in x axis\
//        // e.g. index0: 0*320/4 index1: 1*320/4 index2: 2*320/4
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        // use x to set the value of left constraint
//        horizontalBarLeftAnchorConstraint?.constant = x
//        
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        // image icon base on imageNames array
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)

        return cell
    }
    
    // set size for each item to width / 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    // set spacing between Item to 0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



