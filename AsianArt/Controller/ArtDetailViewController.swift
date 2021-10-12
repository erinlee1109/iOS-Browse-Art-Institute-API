//
//  ArtDetailViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 5/10/21.
//


/// CURRENTLY NOT IN USE


import UIKit
import AlamofireImage

class ArtDetailViewController: UIViewController {
    
    // image and label outlets
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailArtist: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var detailOrigin: UILabel!
    
    var artwork: [String: Any?] = [:]
        
    @IBAction func onTweetThis(_ sender: Any) {
        if let tweetVC = storyboard?.instantiateViewController(withIdentifier: "TweetArt") as? TweetViewController {
            tweetVC.artwork = artwork
            navigationController?.pushViewController(tweetVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image and labels display detailed information of artwork for the selected cell
        
        // detailImage.image = UIImage(named: "https://www.artic.edu/iiif/2/1adf2696-8489-499b-cad2-821d7fde4b33/full/843,/0/default.jpg")
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            detailImage.af.setImage(withURL: imageURL!)
            detailImage.backgroundColor = .lightGray
        }
        
        detailTitle.text = artwork["title"] as? String
        detailArtist.text = artwork["artist_display"] as? String
        detailDate.text = artwork["date_display"] as? String
        detailInfo.text = artwork["medium_display"] as? String
        detailOrigin.text = artwork["place_of_origin"] as? String 
        

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
