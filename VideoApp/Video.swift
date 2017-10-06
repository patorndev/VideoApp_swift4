//
//  Video.swift
//  VideoApp
//
//  Created by Book on 9/7/17.
//  Copyright © 2017 Book. All rights reserved.
//

// Model use Decodable Protocol to decode JSON to 

import UIKit

// video object for each cell
struct Video: Decodable {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    //var uploadDate: NSDate?
    var channel: Channel?
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        thumbnailImageName = rawResponse.thumbnail_image_name
        title = rawResponse.title
        numberOfViews = rawResponse.number_of_views as! NSNumber
        channel = try Channel(from: decoder)
    }
}

struct Channel: Decodable {
    
    var name: String?
    var profileImageName: String?
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        name = rawResponse.channel?.name
        profileImageName = rawResponse.channel?.profile_image_name
    }
}

// snake_case to match the JSON
fileprivate struct RawServerResponse: Decodable {
    var title: String?
    var number_of_views: Int?
    var thumbnail_image_name: String?
    var channel: Channel?
    var duration: Int?
    
    struct Channel: Decodable {
        var name: String?
        var profile_image_name: String?
    }
}

