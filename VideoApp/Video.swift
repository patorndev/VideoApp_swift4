//
//  Video.swift
//  VideoApp
//
//  Created by Book on 9/7/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

// video object for each cell
class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var channel: Channel?
}

// channel profile
class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
