//
//  API.swift
//  AsianArt
//
//  Created by Yujeong Lee on 4/30/21.
//

import Foundation

struct API {
    // static func getArtworks(inputArray:Array<Any>) -> Array<Any> {
    static func getArtworks(completion: @escaping ([[String:Any]]?) -> Void) {
        // print("API function was called")
        // let url = URL(string:"https://api.artic.edu/api/v1/artworks/129884")!
        let url = URL(string:"https://api.artic.edu/api/v1/artworks?fields=id,title,artist_display,date_display")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // print("ok somehow print the data")
                // Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // print(dictionary)
                // print(type(of: dictionary))
//                for (type, info) in dictionary {
//                    if type == "data"{
//                        let this = info
//                        print(this)
//                    }
//                }
// ------------ this part works to make an array of titles ------------- //
//                var artTitles = [String]() // establish an empty array to put titles in
//                var artistDisplays = [String]()
//                var dateDisplays = [String]()
//                if let artData = dataDictionary["data"] as? [[String:Any]] {
//                    for artDataDict in artData {
//                        let title = artDataDict["title"] as! String
//                        artTitles.append(title)
//                        let artistDisplay = artDataDict["artist_display"] as! String
//                        artistDisplays.append(artistDisplay)
//                        let dateDisplay = artDataDict["date_display"] as! String
//                        dateDisplays.append(dateDisplay)
//                    }
//                }
//                print(artTitles)
//                print(artistDisplays)
//                print(dateDisplays)
// ------------ this part works to make an array of titles ------------- //
// ------------ followed yelpy but doesn't work ------------- //
                let artDictionaries = dataDictionary["data"] as! [[String:Any]]
                var artWorks: [[String:Any]] = []
                for dictionary in artDictionaries {
                    artWorks.append(dictionary)
                };
                return completion(artWorks)
// ------------ followed yelpy but doesn't work ------------- //
                }
            }
            task.resume()
        } 
    }
    
