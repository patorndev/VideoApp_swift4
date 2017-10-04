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
            
            guard let data = data else { return }

            do {

                let videos = try JSONDecoder().decode([Video].self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(videos)
                    
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

}
