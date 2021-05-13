//
//  TweetViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 5/12/21.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var myTweet: UITextView!
    var artwork: [String: Any?] = [:]
    var myTweetMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artistLong = artwork["artist_display"] as! String
        let components = artistLong.components(separatedBy: "\n")
        let artistShort = components[0] // only include the artist name in the tweet by detaching artist name from artist birth/death year
        
        myTweetMsg += "\(artwork["title"] as! String) \n"
        myTweetMsg += "\(artistShort) \n"
        myTweetMsg += "\(artwork["date_display"] as! String) \n"
        myTweetMsg += "\(artwork["medium_display"] as! String) \n"
        
//        let image_id = artwork["image_id"] as! String
//        let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
//        myTweetMsg += iiifLink
        
        myTweet.text = myTweetMsg
        
//        if let image_id = artwork["image_id"] as? String {
//            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
//            let imageURL = URL(string: iiifLink)
//            cell.artImage.af.setImage(withURL: imageURL!)
//            cell.artImage.backgroundColor = .lightGray
//        }
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        // dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmTweet(_ sender: Any) {
        if (!myTweet.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: myTweet.text, success: {
                self.navigationController?.popViewController(animated: true)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                // self.navigationController?.popViewController(animated: true)
            })
        } else {
            // self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
