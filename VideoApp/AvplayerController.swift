//
//  AvplayerController.swift
//  VideoApp
//
//  Created by Book on 10/3/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class AvplayerController: UIViewController {

    fileprivate func setupVideoPlayerView() {
        let height = view.frame.width * 9 / 16
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
        view.addSubview(videoPlayerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupVideoPlayerView()
    }

}
