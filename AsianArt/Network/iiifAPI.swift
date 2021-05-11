//
//  iiifAPI.swift
//  AsianArt
//
//  Created by Yujeong Lee on 5/11/21.
//

import Foundation

struct iiifAPI {
    static func getIIIFImage(imageID: String, completion: @escaping ([[String:Any]]?) -> Void) {
        // base IIIF Image API endpoint
        let baseLink = "https://www.artic.edu/iiif/2"
        // append image ID
        // append the details to the URL
        let endLink = "/full/843,/0/default.jpg"
        let iiifLink = baseLink + imageID + endLink
        
        // This is currently force unwrapped. It should be fixed to handle invalid links.
        let url = URL(string: iiifLink)!
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
