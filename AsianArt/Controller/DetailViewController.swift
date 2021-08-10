//
//  DetailViewController.swift
//  AsianArt
//
//  Created by Yujeong Lee on 7/21/21.
//

import Lottie
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var artDetailTitle: UILabel!
    @IBOutlet weak var artistDetailTitle: UILabel!
    
    var artwork: [String: Any?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpLabelTap()
        
        // how do I make this into a function?
        if let image_id = artwork["image_id"] as? String {
            let iiifLink = "https://www.artic.edu/iiif/2/" + image_id + "/full/843,/0/default.jpg"
            let imageURL = URL(string: iiifLink)
            artImageView.af.setImage(withURL: imageURL!)
            artImageView.backgroundColor = .lightGray
        }
        
        artDetailTitle.text = artwork["title"] as? String
        artistDetailTitle.text = artwork["artist_display"] as? String
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.infoView.frame.origin.y + self.infoView.frame.size.height)
        self.scrollView.bounces = true
        self.scrollView.showsVerticalScrollIndicator = true

        // Do any additional setup after loading the view.
    }
    
    // outlet from the tap gesture recog in the details view
    @IBAction func artistTapped(_ sender: UITapGestureRecognizer) {
        if let artistVC = storyboard?.instantiateViewController(withIdentifier: "Artist") as? ArtistViewController {
            artistVC.artist = artwork["artist_display"]
            navigationController?.pushViewController(artistVC, animated: true)
        }
            
    }
    
    // problem:  jul 25 this doesn't work yet 
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if let artImageVC = storyboard?.instantiateViewController(identifier: "ArtImageOnly") as? ArtImageOnlyViewController {
            artImageVC.imageID = artwork["image_id"]
            navigationController?.pushViewController(artImageVC, animated: true)
            
            // self.performSegue(withIdentifier: "ArtImageOnly", sender: self)
        }
    }
    
    // setting up so that UIText tap will be recognized
    func setUpLabelTap(){
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.artistTapped(_:)))
        self.artistDetailTitle.isUserInteractionEnabled = true
        self.artistDetailTitle.addGestureRecognizer(labelTap)
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
