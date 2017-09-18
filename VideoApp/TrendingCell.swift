//
//  TrendingCell.swift
//  VideoApp
//
//  Created by Book on 9/18/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
