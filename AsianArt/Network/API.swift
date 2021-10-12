//
//  API.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/30/21.
//

import Foundation

struct API {
    // static func getArtworks(inputArray:Array<Any>) -> Array<Any> {
    static func getArtworks(link: String, completion: @escaping ([[String:Any]]?) -> Void) {
        
        // URL is already checked for validity before being passed on to be force unwrapped here.
        let url = URL(string: link)!
        // let url = URL(string:"https://api.artic.edu/api/v1/artworks/129884")!
        // let url = URL(string:"https://api.artic.edu/api/v1/artworks/search?q=korea&fields=id,title,artist_display,date_display&limit=30")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let userAgent = "Github: iOS-Browse-Art-Institute-API (erinlee1109@gmail.com)"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent") // is this how you do it?
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let artDictionaries = dataDictionary["data"] as! [[String:Any]]
                var artWorks: [[String:Any]] = []
                for dictionary in artDictionaries {
                    artWorks.append(dictionary)
                };
                return completion(artWorks)
                }
            }
            task.resume()
        } 
    }
    
