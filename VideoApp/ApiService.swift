//
//  ApiService.swift
//  VideoApp
//
//  Created by Book on 9/13/17.
//  Copyright © 2017 Book. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    // singleton
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForURL(url: "\(baseUrl)/home.json", completion: completion)
    }

    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForURL(url: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForURL(url: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForURL(url: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    
                    completion(videos)
                    
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

}
